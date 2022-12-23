//
//  TeacherRevenueViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 11.12.2022.
//

import UIKit


class TeacherRevenueViewController: BaseViewController {
    
    let subView   = UIView()
    let monthView = HeaderMonthView()
    
    let tableView = UITableView()
    
    var teacherName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureNavBar() {
        title = teacherName
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

}

extension TeacherRevenueViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "hello world" + "\(indexPath.row + 1)"
        cell.backgroundColor = "cl_cell_back".color
        return cell
    }
}
