//
//  BranchViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.12.2022.
//

import UIKit

class BranchViewController: BaseViewController {
    
    let subView = UIView()
    
    let tableView = UITableView()
    
    var branchName = ""
    var ind = 10

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureNavBar() {
        title = branchName
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self, action: #selector(addTapped))
        
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
    
    @objc func addTapped(){
        let vc = AddViewController()
        vc.navTitle   = "New Teacher"
        vc.buttonText = "Add"
        vc.nameText   = "New teacher name"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleMoveToTrash(index: Int) {
        showActionAlert(title: "Warning", message: "Are you sure that you want to delete a branch?", actions: ["Yes", "No"]){ [weak self] action in
            if action.title == "Yes" {
                self?.ind -= 1
                self?.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
            }
        }
    }
}

extension BranchViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ind
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        cell.text = "teacher name \(indexPath.row + 1)"
        cell.initViews()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = TeacherViewController()
        vc.teacherName = "teacher name \(indexPath.row + 1)"
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
