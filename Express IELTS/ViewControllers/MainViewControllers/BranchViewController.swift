//
//  BranchViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.12.2022.
//

import UIKit

class BranchViewController: BaseViewController {
    
    let presenter = TeacherListPresenter()
    
    let subView   = UIView()
    let tableView = UITableView()
    let refresh   = UIRefreshControl()
    
    var branchName = ""
    var teachers   = [String]()
    var loaded     = true

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDelegate(delegate: self)
        presenter.getAllTeachers()
    }
    
    override func configureNavBar() {
        title = branchName
        
        var menuItems: [UIAction] {
            return [
                UIAction(title: "new_teacher".localized, image: UIImage(systemName: "plus.app"),
                         handler: { [weak self] (_) in
                    self?.addTapped()
                }),
                UIAction(title: "edit".localized, image: UIImage(systemName: "pencil"),
                         handler: { [weak self] (_) in
                    print("hello 2")
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
        presenter.getAllTeachers()
    }
    
    @objc func addTapped(){
        let vc = AddViewController()
        vc.navTitle   = "new_teacher".localized
        vc.buttonText = "add".localized
        vc.nameText   = "new_teacher_name".localized
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleMoveToTrash(index: IndexPath) {
        showActionAlert(title: String(format: "delete_info".localized, "teacher".localized), message: nil,
                        actions: ["delete".localized]){ [weak self] action in
            if action.title == "delete".localized {
                self?.showLoading()
                self?.deleteTeacher(index: index)
            }
        }
    }
    
    func deleteTeacher(index: IndexPath) {
        FirebaseManager.shared.deleteTeacher(teacherName: teachers[index.row]) { [weak self] in
            self?.hideLoading()
            self?.teachers.remove(at: index.row)
            self?.tableView.deleteRows(at: [index], with: .left)
        } error: { [weak self] err in
            self?.hideLoading()
            self?.showErrorMessage(title: err)
        }
    }
    
    private func reloadData() {
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

extension BranchViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loaded ? teachers.count : 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if loaded {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
            cell.text = teachers[indexPath.row].capitalized
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = TeacherViewController()
        Database.shared.currentTeacher = teachers[indexPath.row]
        vc.teacherName = teachers[indexPath.row].capitalized
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Swipe Actions
    //left swipe
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "delete".localized) { [weak self] (_, _, completionHandler) in
            self?.handleMoveToTrash(index: indexPath)
            completionHandler(true)
        }
        delete.backgroundColor = .systemRed
        delete.image = UIImage(systemName: "trash")?.withTintColor(.white)
        let config = UISwipeActionsConfiguration(actions: [delete])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    //right swipe
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let add = UIContextualAction(style: .normal, title: "edit".localized) { [weak self] (_, _, completionHandler) in
            self?.handleMoveToTrash(index: indexPath)
            completionHandler(true)
        }
        add.backgroundColor = .systemGreen
        add.image = UIImage(systemName: "square.and.pencil.circle")?.withTintColor(.white)
        let config = UISwipeActionsConfiguration(actions: [add])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}

extension BranchViewController: TeacherListDelegate {
    func onSuccessGetAllTeachers(teachers: [String]) {
        self.teachers = teachers
        reloadData()
    }
    
    func onErrorGetAllTeachers(error: String?) {
        showErrorMessage(title: error)
    }
}
