//
//  StudentListViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.12.2022.
//

import UIKit

class GroupViewController: BaseViewController {
    
    let presenter = StudentListPresenter()
    
    let subView   = UIView()
    let monthView = HeaderMonthView()
    let tableView = UITableView()
    let refresh   = UIRefreshControl()
    
    var group: Group?
    var students  = [StudentWithAttendance]()
    var canEdit   = false
    var loaded    = false
    var index     = IndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDelegate(delegate: self)
        presenter.getAllGroupStudents(groupID: group?.id?.description ?? "", year: 2023, month: 2)
    }
    
    override func configureNavBar() {
        title = group?.groupName.capitalized
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
        presenter.getAllGroupStudents(groupID: group?.id?.description ?? "", year: 2023, month: 2)
    }
    
    @objc func addTapped() {
        let vc = aAddViewController()
        vc.navTitle   = "new_student".localized
        vc.addBtnText = "add".localized
        vc.firstFieldText   = "new_student_name".localized
        vc.secondFieldText  = "Phone number"
        navigationController?.pushViewController(vc, animated: true)
    }

    private func handleMoveToTrash(index: IndexPath) {

        showActionAlert(title:String(format: "delete_info".localized, "group".localized), message: nil,
                        actions: ["delete".localized]){ [weak self] action in

               if action.title == "delete".localized {
                self?.showLoading()
                self?.index = index
                self?.presenter.deleteStudent(studentID: self?.students[index.row].student.id?.description ?? "")
            }
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

extension GroupViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loaded ? students.count : 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if loaded {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StudentCheckTableViewCell
            cell.student = students[indexPath.row]
            cell.size = Int(group?.groupType ?? "12") ?? 12
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
    
    //left swipe
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

extension GroupViewController: StudentListDelegate {
    func onSuccessGetAllGroupStudents(students: [StudentWithAttendance]) {
        DispatchQueue.main.async { [weak self] in
            self?.students = students
            self?.reloadData()
        }
    }
    
    func onSuccessGetAllBranchStudents(students: [Student]) { }
    
    func onSuccessDeleteStudent() {
        hideLoading()
        students.remove(at: index.row)
        tableView.deleteRows(at: [index], with: .left)
    }
    
    func onError(error: String?) {
        showErrorMessage(title: error)
    }
}

extension GroupViewController: PaidDelegate {
    func pay(for student: String) {
//        showAlertWithTextField(title: student, message: "Enter a sum") { [weak self] text in
//            self?.showLoading()
//            FirebaseManager.shared.addReceipt(studentName: student, sum: text) { [weak self] in
//                self?.hideLoading()
//            } error: { [weak self] err in
//                self?.hideLoading()
//                self?.showErrorMessage(title: err)
//            }
//        } error: { [weak self] err in
//            self?.showErrorMessage(title: err)
//        }
    }
}
