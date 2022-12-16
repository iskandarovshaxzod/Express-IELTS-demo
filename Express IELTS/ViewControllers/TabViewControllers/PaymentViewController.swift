//
//  PaymentViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 05.12.2022.
//

import UIKit
import SnapKit

class PaymentViewController: BaseViewController {
    
    let subView = UIView()
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
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
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate   = self
        tableView.dataSource = self
    }
}

extension PaymentViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        cell.text = "branch name \(indexPath.row + 1)"
        cell.initViews()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            navigationController?.pushViewController(MonthlyPaymentViewController(), animated: true)
        } else {
            let vc = BranchRevenueViewController()
            vc.branchName = "branch name \(indexPath.row + 1)"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
