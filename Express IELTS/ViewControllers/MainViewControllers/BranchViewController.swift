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
    
    var branchName = ""
    var teachers   = [String]()

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
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
    }
    
    @objc func addTapped(){
        let vc = AddViewController()
        vc.navTitle   = "new_teacher".localized
        vc.buttonText = "add".localized
        vc.nameText   = "new_teacher_name".localized
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleMoveToTrash(index: Int) {
        showActionAlert(title: "Are you sure that you want to delete a branch?", message: nil,
                        actions: ["delete".localized]){ [weak self] action in
            if action.title == "delete".localized {
                self?.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
            }
        }
    }
    
    private func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension BranchViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teachers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        cell.text = teachers[indexPath.row]
        cell.initViews()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = TeacherViewController()
        vc.teacherName = teachers[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Swipe Actions
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "delete".localized) { [weak self] (_, _, completionHandler) in
            self?.handleMoveToTrash(index: indexPath.row)
            completionHandler(true)
        }
        delete.backgroundColor = .systemRed
        delete.image = UIImage(systemName: "trash")?.withTintColor(.white)
        let config = UISwipeActionsConfiguration(actions: [delete])
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
