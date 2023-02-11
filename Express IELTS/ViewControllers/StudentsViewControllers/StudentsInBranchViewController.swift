//
//  StudentsInBranchViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 15.12.2022.
//

import UIKit

class StudentsInBranchViewController: BaseViewController {
    
    let presenter = AllStudentListPresenter()
    
    let subView   = UIView()
    let monthView = HeaderMonthView()
    let tableView = UITableView()
    
    var students   = [String]()
    var branchName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDelegate(delegate: self)
        presenter.getAllStudents(monthName: "November")
    }
    
    override func configureNavBar() {
        title = branchName.capitalized
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
        cell.textLabel?.text = students[indexPath.row]
        cell.backgroundColor = "cl_cell_back".color
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = StudentReceiptViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.text = "Student Info"
        present(vc, animated: false)
    }
}

extension StudentsInBranchViewController: AllStudentListDelegate {
    func onSuccessGetAllStudents(students: [String]) {
        self.students = students
        reloadData()
    }
    
    func onErrorGetAllStudents(error: String?) {
        showErrorMessage(title: error)
    }
}

extension StudentsInBranchViewController: HeaderMonthChanged {
    func monthChanged(to month: String) {
        presenter.getAllStudents(monthName: month)
    }
}
