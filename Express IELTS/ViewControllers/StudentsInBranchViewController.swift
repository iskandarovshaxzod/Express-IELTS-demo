//
//  StudentsInBranchViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 15.12.2022.
//

import UIKit

class StudentsInBranchViewController: BaseViewController {
    
    let subView = UIView()
    
    let tableView = UITableView()
    
    var branchName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureNavBar() {
        title = branchName
    }
    
    override func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = .white
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.backgroundColor = .white
        tableView.register(HeaderMonthTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
    }

}

extension StudentsInBranchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.row == 0 {
            let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HeaderMonthTableViewCell
            tableCell.initViews()
            cell = tableCell
        } else {
//            cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
            cell.textLabel?.text = "student name " + "\(indexPath.row + 1)"
        }
        return cell
    }
}
