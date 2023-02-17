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
    let noDataImg = UIImageView()
    
    var group: Group?
    var students  = [StudentWithAttendance]()
    var loaded    = false
    var index     = IndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()        
        presenter.setDelegate(delegate: self)
        presenter.getAllGroupStudents(groupID: group?.id?.description ?? "", year: 2023, month: 2)
    }
    
    override func configureNavBar() {
        title = group?.groupName.capitalized
        
        var menuItems: [UIAction] {
            return [
                UIAction(title: "new_student".localized, image: UIImage(systemName: "plus.app"),
                         handler: { [weak self] (_) in
                    self?.addTapped()
                }),
                UIAction(title: Database.shared.canCheck ? "done" : "edit".localized,
                         image: Database.shared.canCheck ? UIImage(systemName: "checkmark") :
                                                           UIImage(systemName: "pencil"),
                         handler: { [weak self] (_) in
                             if Database.shared.canCheck {
                                 
                             }
                             Database.shared.canCheck.toggle()
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
        
        subView.addSubview(noDataImg)
        noDataImg.snp.makeConstraints { make in
            make.top.equalTo(monthView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        noDataImg.image       = UIImage(named: "no_data")
        noDataImg.contentMode = .scaleAspectFit
        noDataImg.isHidden    = true
        
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
        vc.firstFieldPlaceholder  = "new_student_name".localized
        vc.secondFieldPlaceholder = "Phone number"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleCall(index: IndexPath) {
        callNumber(phoneNumber: students[index.row].student.phoneNumber)
    }
    
    func handleEdit(index: IndexPath) {
        showAlertWithTextField(title: "edit teacher",
                               texts: [students[index.row].student.studentName.capitalized,
                                       students[index.row].student.phoneNumber]) {
            [weak self] texts in
            
            if texts.count > 1 {
                self?.showLoading()
                self?.presenter.updateStudent(studentID: self?.students[index.row]
                                              .student.id?.description ?? "",
                                              name: texts[0],
                                              phoneNumber: texts[1])
            }
        } error: { [weak self] err in
            self?.onError(error: err)
        }
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
    
    func showSucess() {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            self?.showAnimation(animationName: "success", animationMode: .playOnce) { _ in
                self?.hideAnimation()
            }
        }
    }
}

extension StudentListViewController: UITableViewDelegate, UITableViewDataSource{
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
            
            let call = UIAction(title: "call".localized,
                                image: UIImage(systemName: "phone")) {
                [weak self] _ in
                self?.handleCall(index: indexPath)
            }
            let edit = UIAction(title: "edit".localized,
                                image: UIImage(systemName: "square.and.pencil.circle")) {
                [weak self] _ in
                self?.handleEdit(index: indexPath)
            }
            let delete = UIAction(title: "delete".localized, image: UIImage(systemName: "trash"),
                                  attributes: .destructive) {
                [weak self] _ in
                self?.handleMoveToTrash(index: indexPath)
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: [],
                          children: [call, edit, delete])
        }
        return config
    }
}

extension StudentListViewController: StudentListDelegate {
    
    func onSuccessGetAllGroupStudents(students: [StudentWithAttendance]) {
        DispatchQueue.main.async { [weak self] in
            self?.students = students
            self?.reloadData()
        }
    }
    
    func onSuccessPayForStudent() {
        showSucess()
    }
    
    func onSuccessUpdateStudent() {
        showSucess()
    }
    
    func onSuccessDeleteStudent() {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            self?.students.remove(at: self?.index.row ?? 0)
            self?.tableView.deleteRows(at: [self?.index ?? IndexPath()], with: .left)
        }
    }
    
    func onError(error: String?) {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            self?.showErrorMessage(title: error)
        }
    }
    
    func onSuccessGetAllBranchStudents(students: [Student]) { }
}

extension StudentListViewController: PaidDelegate {
    func pay(for student: Student) {
        showAlertWithTextField(title: "enter sum", message: "message for you",
                               placeholders: ["current", "max"], keyboardType: .numberPad) {
            [weak self] sums in
            let paid = Double(sums[0]) ?? 0.0
            let max  = Double(sums[1]) ?? 0.0
            self?.showLoading()
            self?.presenter.payForStudent(paidSum: paid, maxSum: max, student: student,
                                          teacherID: Database.shared.teacherID,
                                          groupID:   Database.shared.groupID)
        } error: { [weak self] err in
            self?.onError(error: err)
        }
    }
}
