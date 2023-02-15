//
//  ChangePasswordViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 23.12.2022.
//

import UIKit

class ChangePasswordViewController: BaseViewController {
    
    let presenter = UserMethodsPresenter()
    
    let subView   = UIView()
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var users = [[User]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDelegate(delegate: self)
        presenter.getAllUsers()
    }
    
    override func configureNavBar() {
        title = "change_pass".localized
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
        tableView.delegate   = self
        tableView.dataSource = self
    }
}

extension ChangePasswordViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "admin".localized : "branches".localized
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users[section].count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text  = users[indexPath.section][indexPath.row].login.capitalized
        cell.backgroundColor  = "cl_cell_back".color
        cell.imageView?.image = UIImage(systemName: indexPath.section == 0 ? "person.circle" : "bookmark.circle")
        cell.accessoryType    = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ChangePassCodeViewController()
        vc.user = users[indexPath.section][indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ChangePasswordViewController: UserMethodsDelegate {
    func onSuccessGetAllUsers(users: [[User]]) {
        DispatchQueue.main.async { [weak self] in
            self?.users = users
            self?.tableView.reloadData()
        }
    }
    
    func onError(error: String?) {
        DispatchQueue.main.async { [weak self] in
            self?.showErrorMessage(title: error)
        }
    }
    
    func onSuccessValidateUser() {}
    func onSuccessChangePassword() {}
}
