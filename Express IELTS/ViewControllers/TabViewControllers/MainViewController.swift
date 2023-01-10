//
//  MainViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 05.12.2022.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController {
 
    let presenter = BranchListPresenter()
    
    let subView   = UIView()
    let tableView = UITableView()
    let refresh   = UIRefreshControl()
    
    var branches = FirebaseManager.shared.branches
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
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.addSubview(refresh)
        refresh.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
    }
    
    private func handleMoveToTrash(index: IndexPath) {
        showActionAlert(title: "Are you sure that you want to delete a branch?", message: nil,
                        actions: ["delete".localized]) { [weak self] action in
            if action.title == "delete".localized {
                self?.showLoading()
                self?.deleteBranch(index: index)
            }
        }
    }
    
    func deleteBranch(index: IndexPath) {
        FirebaseManager.shared.deleteBranch(branchName: branches[index.row]) { [weak self] in
            self?.hideLoading()
            self?.branches.remove(at: index.row)
            self?.tableView.deleteRows(at: [index], with: .left)
        } error: { [weak self] err in
            self?.hideLoading()
            self?.showErrorMessage(title: err)
        }
    }
    
    private func reloadData() {
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
    
    @objc func refreshTable() {
        presenter.getAllBranches()
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    
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
        } else {
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
        if let _ = tableView.cellForRow(at: indexPath) as? ListTableViewCell {
            let vc = BranchViewController()
            Database.shared.currentBranch = branches[indexPath.row]
            vc.branchName = branches[indexPath.row].capitalized
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    //MARK: - Swipe Actions
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "delete".localized) { [weak self] (_, _, completionHandler) in
            self?.handleMoveToTrash(index: indexPath)
            completionHandler(true)
        }
        delete.backgroundColor = .systemRed
        delete.image = UIImage(systemName: "trash")?.withTintColor(.white)
        let c = UISwipeActionsConfiguration(actions: [delete])
        c.performsFirstActionWithFullSwipe = false
        return (Database.shared.isAdmin ? c : nil)
    }
}

extension MainViewController: BranchListDelegate {
    func onSuccessGetAllBranches(branches: [String]) {
//        self.branches = branches
        reloadData()
    }
    func onErrorGetAllBranches(error: String?) {
        showErrorMessage(title: error)
    }
}
