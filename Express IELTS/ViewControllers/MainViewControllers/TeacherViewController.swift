//
//  TeacherViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.12.2022.
//

import UIKit

class TeacherViewController: BaseViewController {
    
    let subView = UIView()
    
    let tableView = UITableView()
    
    var teacherName = ""
    var ind = 10

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureNavBar() {
        title = teacherName
        
        var menuItems: [UIAction] {
            return [
                UIAction(title: "new_teacher_config".localized, image: UIImage(systemName: "plus.app"),
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
        
    }
    
    @objc func addTapped() {
        let vc = AddViewController()
        vc.navTitle   = "new_teacher_config".localized
        vc.buttonText = "add".localized
        vc.nameText   = "new_teacher_config_name".localized
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleMoveToTrash(index: Int) {
        showActionAlert(title: "Are you sure that you want to delete a branch?", message: nil,
                        actions: ["delete".localized]){ [weak self] action in
            if action.title == "delete".localized {
                self?.ind -= 1
                self?.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
            }
        }
    }
}

extension TeacherViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ind
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        cell.text = "config \(indexPath.row + 1)"
        cell.initViews()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = GroupViewController()
        vc.configName = "Config name \(indexPath.row + 1)"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Swipe Actions
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "Delete") { [weak self] (_, _, completionHandler) in
            self?.handleMoveToTrash(index: indexPath.row)
            completionHandler(true)
        }
        delete.backgroundColor = .systemRed
        delete.image = UIImage(named: "ic_trash")?.withTintColor(.white)
        let c = UISwipeActionsConfiguration(actions: [delete])
        c.performsFirstActionWithFullSwipe = false
        return (Database.shared.isAdmin ? c : nil)
    }
}
