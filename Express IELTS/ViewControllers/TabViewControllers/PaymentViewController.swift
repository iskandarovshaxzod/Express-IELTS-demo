//
//  PaymentViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 05.12.2022.
//

import UIKit
import SnapKit

class PaymentViewController: BaseViewController {
    
    let presenter = BranchListPresenter()
    
    let subView   = UIView()
    let tableView = UITableView()
    let refresh   = UIRefreshControl()
    
    var branches = [String]()
    var loaded   = false

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDelegate(delegate: self)
        presenter.getAllBranches()
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
        tableView.register(SkeletonTableViewCell.self, forCellReuseIdentifier: "skeleton")
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.addSubview(refresh)
        refresh.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
    }
    
    func reloadData(){
        loaded = true
        if loaded {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.tableView.reloadData()
            }
        }
        refresh.endRefreshing()
    }
    
    @objc func refreshTable() {
        presenter.getAllBranches()
    }
}

extension PaymentViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loaded ? branches.count : 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if loaded {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
            cell.text = branches[indexPath.row].capitalized
            cell.initViews()
            cell.selectionStyle = .none
            return cell
        }  else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "skeleton", for: indexPath) as! SkeletonTableViewCell
            cell.initViews()
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == branches.count - 1 {
            navigationController?.pushViewController(MonthlyPaymentViewController(), animated: true)
        } else {
            let vc = BranchRevenueViewController()
            Database.shared.currentBranch = branches[indexPath.row]
            vc.branchName = branches[indexPath.row].capitalized
            navigationController?.pushViewController(vc, animated: true)
        }
//        if indexPath.row == 4 {
//            navigationController?.pushViewController(MonthlyPaymentViewController(), animated: true)
//        } else {
//            let vc = BranchRevenueViewController()
//            vc.branchName = "branch name \(indexPath.row + 1)"
//            navigationController?.pushViewController(vc, animated: true)
//        }
    }
}

extension PaymentViewController: BranchListDelegate {
    func onSuccessGetAllBranches(branches: [String]) {
        self.branches = branches + ["all_branches".localized]
        reloadData()
    }
    
    func onErrorGetAllBranches(error: String?) {
        showErrorMessage(title: error)
    }
}
