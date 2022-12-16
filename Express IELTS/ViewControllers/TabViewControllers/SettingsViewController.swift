//
//  SettingsViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 05.12.2022.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    let subView   = UIView()
    
    let tableView = UITableView()
    
    let texts = ["Change password", "User mode", "Language"]

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
    }
    
    override func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = "cl_main_back".color
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(texts.count * 50)
        }
        tableView.backgroundColor = "cl_main_back".color
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 10
        tableView.isScrollEnabled    = false
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = texts[indexPath.row]
        cell.backgroundColor = "cl_cell_back".color
        cell.imageView?.image = UIImage(systemName: "paperclip")
        cell.accessoryType   = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if texts[indexPath.row] == "Change password" {
            if Database.shared.isAdmin {
                // Let admin change password
            } else {
                // Show some animation
            }
        }
    }
    
}
//59 130 247
