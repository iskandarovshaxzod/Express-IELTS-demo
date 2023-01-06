//
//  ChangePasswordViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 23.12.2022.
//

import UIKit

class ChangePasswordViewController: BaseViewController {
    
    let subView   = UIView()
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var branches = ["mega", "novza", "sergeli"]

    override func viewDidLoad() {
        super.viewDidLoad()
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "admin".localized : "branches".localized
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : branches.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text  = (indexPath.section == 0 ? "admin".localized : branches[indexPath.row])
        cell.backgroundColor  = "cl_cell_back".color
        cell.imageView?.image = UIImage(systemName: indexPath.section == 0 ? "person.circle" : "bookmark.circle")
        cell.accessoryType    = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ChangePassCodeViewController()
        vc.title = (indexPath.section == 0 ? "admin".localized : branches[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
