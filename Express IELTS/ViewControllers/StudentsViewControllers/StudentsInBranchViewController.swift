//
//  StudentsInBranchViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 15.12.2022.
//

import UIKit

class StudentsInBranchViewController: BaseViewController {
    
    let presenter = StudentListPresenter()
    
    let subView   = UIView()
    let monthView = HeaderMonthView()
    let tableView = UITableView()
    let noDataImg = UIImageView()
    
    var branch: Branch?
    var students   = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDelegate(delegate: self)
        presenter.getAllBranchStudents(branchID: branch?.id?.description ?? "", year: 2023, month: 2)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoading()
    }
    
    
    override func configureNavBar() {
        title = branch?.branchName.capitalized
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
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension StudentsInBranchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = students[indexPath.row].studentName.capitalized
        cell.backgroundColor = "cl_cell_back".color
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = StudentReceiptViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.texts = [
            ("Joined Date", "\(students[indexPath.row].joinedDate?.date ?? "")"),
            ("Left Date", "\(students[indexPath.row].leftDate?.date ?? "Active")"),
            ("Phone Number", "\(students[indexPath.row].phoneNumber)")
        ]
        vc.canCall = true
        present(vc, animated: false)
    }
}

extension StudentsInBranchViewController: StudentListDelegate {
    
    func onSuccessGetAllBranchStudents(students: [Student]) {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            self?.students = students
            self?.reloadData()
        }
    }
    
    func onError(error: String?) {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            self?.showErrorMessage(title: error)
        }
    }
    
    func onSuccessGetAllGroupStudents(students: [StudentWithAttendance]) {}
    func onSuccessDeleteStudent() {}
    func onSuccessUpdateStudent() {}
    func onSuccessPayForStudent() {}
}

extension StudentsInBranchViewController: HeaderMonthChanged {
    func monthChanged(to month: Months) {
        
    }
}
