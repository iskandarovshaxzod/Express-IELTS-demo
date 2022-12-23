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
    
    let texts = ["change_pass".localized, "user_mode".localized, "language".localized]
    let icons = ["lock", "paperclip", "paperclip"]

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
        cell.imageView?.image = UIImage(systemName: icons[indexPath.row])
        cell.accessoryType   = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            if Database.shared.isAdmin {
                // Let admin change password
            } else {
                // Show some animation
            }
        } else if indexPath.row == 1 {
            let vc = ChangeSettingsViewController()
            vc.texts = ["System", "Dark", "Light"]
            vc.icons = ["iphone.smartbatterycase.gen2", "moon.fill", "sun.max"]
            vc.isLan = false
            present(vc, animated: true)
        } else {
            let vc = ChangeSettingsViewController()
            vc.texts = ["English", "Russian", "Uzbek"]
            vc.icons = ["paperclip", "paperclip", "paperclip"]
            vc.isLan = true
            present(vc, animated: true)
        }
    }
    
}
