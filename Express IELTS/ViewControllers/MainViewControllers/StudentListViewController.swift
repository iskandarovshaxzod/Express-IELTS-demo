//
//  StudentListViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.12.2022.
//

import UIKit

class StudentListViewController: BaseViewController {
    
    let presenter = StudentListPresenter()
    
    let subView   = UIView()
    let monthView = HeaderMonthView()
    let tableView = UITableView()
    let refresh   = UIRefreshControl()
    
    var groupName = ""
    var students  = [StudentCheckModel]()
    var canEdit   = false
    var loaded    = false

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDelegate(delegate: self)
        presenter.getAllStudents()
    }
    
    override func configureNavBar() {
        title = groupName
        print("number: \(students.count)")
        var menuItems: [UIAction] {
            return [
                UIAction(title: "new_student".localized, image: UIImage(systemName: "plus.app"),
                         handler: { [weak self] (_) in
                    self?.addTapped()
                }),
                UIAction(title: canEdit ? "done" : "edit".localized,
                         image: canEdit ? UIImage(systemName: "checkmark") : UIImage(systemName: "pencil"),
                         handler: { [weak self] (_) in
                             self?.canEdit.toggle()
                             self?.configureNavBar()
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
        
        subView.addSubview(monthView)
        monthView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(monthView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
        tableView.backgroundColor = "cl_main_back".color
        tableView.register(StudentCheckTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(SkeletonViewsTableViewCell.self, forCellReuseIdentifier: "skeleton")
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .singleLine
        tableView.addSubview(refresh)
        refresh.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
    }
    
    @objc func refreshTable() {
        presenter.getAllStudents()
    }
    
    @objc func addTapped() {
        let vc = AddViewController()
        vc.navTitle   = "new_student".localized
        vc.buttonText = "add".localized
        vc.nameText   = "new_student_name".localized
        navigationController?.pushViewController(vc, animated: true)
    }

    private func handleMoveToTrash(index: IndexPath) {
        showActionAlert(title: String(format: "delete_info".localized,"student".localized),
                        message: nil, actions: ["delete".localized]){ [weak self] action in
            if action.title == "delete".localized {
                self?.showLoading()
                self?.deleteStudent(index: index)
            }
        }
    }
    
    func deleteStudent(index: IndexPath) {
        FirebaseManager.shared.deleteStudent(studentName: students[index.row].studentName) { [weak self] in
            self?.hideLoading()
            self?.students.remove(at: index.row)
            self?.tableView.deleteRows(at: [index], with: .left)
        } error: { [weak self] err in
            self?.hideLoading()
            self?.showErrorMessage(title: err)
        }
    }
    
    private func reloadData(){
        if loaded {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.tableView.reloadData()
            }
            loaded = true
        }
        refresh.endRefreshing()
    }
}

extension StudentListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loaded ? students.count : 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if loaded {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StudentCheckTableViewCell
            cell.name = students[indexPath.row].studentName.capitalized
            cell.delegate = self
            cell.initViews()
            cell.selectionStyle = .none
            return cell
        }  else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "skeleton", for: indexPath) as! SkeletonViewsTableViewCell
            cell.initViews()
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
//    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
//        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
//            let edit = UIAction(title: "edit".localized, image: UIImage(systemName: "square.and.pencil.circle"),
//                                  attributes: .destructive) { [weak self] _ in
//                self?.handleMoveToTrash(index: indexPath)
//            }
//            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [edit])
//        }
//        return config
//    }
//
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let delete = UIAction(title: "delete".localized, image: UIImage(systemName: "trash"),
                                  attributes: .destructive) { [weak self] _ in
                self?.handleMoveToTrash(index: indexPath)
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [delete])
        }
        return config
    }
    
    //MARK: - Swipe Actions
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "delete".localized) {
            [weak self] (_, _, completionHandler) in
            self?.handleMoveToTrash(index: indexPath)
            completionHandler(true)
        }
        delete.backgroundColor = .systemRed
        delete.image = UIImage(systemName: "trash")?.withTintColor(.white)
        let config = UISwipeActionsConfiguration(actions: [delete])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}

extension StudentListViewController: StudentListDelegate {
    func onSuccessGetAllStudents(students: [String]) {
        presenter.getAllStudentsData(students: students)
    }
    
    func onSuccessGetAllStudentsData(students: [StudentCheckModel]) {
        self.students = students
        reloadData()
    }
    
    func onErrorGetAllStudents(error: String?) {
        showErrorMessage(title: error)
    }
}

extension StudentListViewController: PaidDelegate {
    func pay(for student: String) {
        showAlertWithTextField(title: student, message: "Enter a sum") { [weak self] text in
            self?.showLoading()
            FirebaseManager.shared.addReceipt(studentName: student, sum: text) { [weak self] in
                self?.hideLoading()
            } error: { [weak self] err in
                self?.hideLoading()
                self?.showErrorMessage(title: err)
            }
        } error: { [weak self] err in
            self?.showErrorMessage(title: err)
        }
    }
}
