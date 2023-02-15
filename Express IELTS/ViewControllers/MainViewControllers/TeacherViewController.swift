//
//  TeacherViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.12.2022.
//

import UIKit

class TeacherViewController: BaseViewController {
    
    let presenter = TeacherConfigListPresenter()
    
    let subView   = UIView()
    let tableView = UITableView()
    let refresh   = UIRefreshControl()
    
    var teacher: Teacher?
    var configs = [Config]()
    var loaded  = true
    var index   = IndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDelegate(delegate: self)
        presenter.getAllTeacherConfigs(teacherID: teacher?.id?.description ?? "")
    }

    override func configureNavBar() {
        title = teacher?.teacherName.capitalized
        
        var menuItems: [UIAction] {
            return [
                UIAction(title: "new_teacher_config".localized, image: UIImage(systemName: "plus.app"),
                         handler: { [weak self] (_) in
                    self?.addTapped()
                })
            ]
        }
        var demoMenu: UIMenu {
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "ellipsis"), primaryAction: nil, menu: demoMenu)
    }
    
    override func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = "cl_main_back".color
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.backgroundColor = "cl_main_back".color
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(SkeletonTableViewCell.self, forCellReuseIdentifier: "skeleton")
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.addSubview(refresh)
        refresh.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
    }
    
    @objc func refreshTable() {
        presenter.getAllTeacherConfigs(teacherID: teacher?.id?.description ?? "")
    }
    
    @objc func addTapped() {
        let vc = aAddViewController()
        vc.navTitle   = "new_teacher_config".localized
        vc.addBtnText = "add".localized
        vc.firstFieldPlaceholder  = "new_teacher_config_name".localized
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleEdit(index: IndexPath) {
        showAlertWithTextField(title: "edit teacher",
                               texts: [configs[index.row].configName.capitalized]) {
            [weak self] texts in
            self?.showLoading()
            self?.presenter.updateConfig(configID: self?.configs[index.row].id?.description ?? "",
                                         name: texts.first ?? "")
        } error: { [weak self] err in
            self?.onError(error: err)
        }
    }
    
    private func handleMoveToTrash(index: IndexPath) {
        showActionAlert(title: String(format: "delete_info".localized, "config"), message: nil,
                        actions: ["delete".localized]){ [weak self] action in
            if action.title == "delete".localized {
                self?.showLoading()
                self?.index = index
                self?.presenter.deleteConfig(configID: self?.configs[index.row].id?.description ?? "")
            }
        }
    }
    
    private func reloadData(){
        loaded = true
        if loaded {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.tableView.reloadData()
            }
        }
        refresh.endRefreshing()
    }
}

extension TeacherViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loaded ? configs.count : 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if loaded {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
            cell.text = configs[indexPath.row].configName.capitalized
            cell.initViews()
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "skeleton", for: indexPath) as! SkeletonTableViewCell
            cell.initViews()
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ConfigViewController()
        Database.shared.configID = configs[indexPath.row].id?.description ?? ""
        vc.config = configs[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Swipe Actions
    
    //Left swipe
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "delete".localized) { [weak self] (_, _, completionHandler) in
            self?.handleMoveToTrash(index: indexPath)
            completionHandler(true)
        }
        delete.backgroundColor = .systemRed
        delete.image = UIImage(systemName: "trash")?.withTintColor(.white)
        let configs = UISwipeActionsConfiguration(actions: [delete])
        configs.performsFirstActionWithFullSwipe = false
        return configs
    }
    //Right swipe
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let add = UIContextualAction(style: .normal, title: "edit".localized) { [weak self] (_, _, completionHandler) in
            self?.handleEdit(index: indexPath)
            completionHandler(true)
        }
        add.backgroundColor = .systemGreen
        add.image = UIImage(systemName: "square.and.pencil.circle")?.withTintColor(.white)
        let config = UISwipeActionsConfiguration(actions: [add])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}

extension TeacherViewController: TeacherConfigListDelegate {
    
    func onSuccessGetAllTeacherConfigs(configs: [Config]) {
        DispatchQueue.main.async { [weak self] in
            self?.configs = configs
            self?.reloadData()
        }
    }
    
    func onSuccessUpdateConfig() {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            self?.showAnimation(animationName: "success", animationMode: .playOnce) { _ in
                self?.hideAnimation()
            }
        }
    }
    
    func onSuccessDeleteConfig() {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            self?.configs.remove(at: self?.index.row ?? 0)
            self?.tableView.deleteRows(at: [self?.index ?? IndexPath()], with: .left)
        }
    }
    
    func onError(error: String?) {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            self?.showErrorMessage(title: error)
        }
    }
}
