//
//  BranchRevenueViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 11.12.2022.
//

import UIKit

class BranchRevenueViewController: BaseViewController {
    
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

    private func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension BranchRevenueViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teachers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        cell.text = teachers[indexPath.row]
        cell.initViews()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TeacherRevenueViewController()
        Database.shared.currentTeacher = teachers[indexPath.row]
        vc.teacherName = teachers[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension BranchRevenueViewController: TeacherListDelegate {
    func onSuccessGetAllTeachers(teachers: [String]) {
        self.teachers = teachers
        reloadData()
    }
    
    func onErrorGetAllTeachers(error: String?) {
        showErrorMessage(title: error)
    }
}
