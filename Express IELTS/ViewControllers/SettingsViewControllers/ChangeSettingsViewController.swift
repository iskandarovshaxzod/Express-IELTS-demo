//
//  ChangeSettingsViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 22.12.2022.
//

import UIKit

class ChangeSettingsViewController: BaseViewController {
    
    let subView   = UIView()
    let tableView = UITableView()
    
    var texts = ["", "", ""]
    var icons = ["", "", ""]
    var current = 0
    var isLan = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        check()
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
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 10
        tableView.isScrollEnabled    = false
    }
    
    func check() {
        if isLan{
            switch Database.shared.language {
            case .english:
                current = 0
            case .russian:
                current = 1
            case .uzbek:
                current = 2
            }
        } else {
            current = Database.shared.userMode.rawValue
        }
    }
    
    func changed(index: Int) {
        if isLan {
            switch index {
                case 0: Defaults.defaults.setValue("en", forKey: "language")
                case 1: Defaults.defaults.setValue("ru", forKey: "language")
                case 2: Defaults.defaults.setValue("uz", forKey: "language")
                default: break
            }
        } else {
            switch index {
                case 0: Defaults.defaults.setValue(0, forKey: "user_mode")
                case 1: Defaults.defaults.setValue(1, forKey: "user_mode")
                case 2: Defaults.defaults.setValue(2, forKey: "user_mode")
                default: break
            }
        }
        if current != index {
            dismis()
        }
        current = index
    }
    
    func dismis() {
        if !isLan {
            if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                scene.checkUserMode()
            }
        }
        dismiss(animated: true) { [weak self] in
            self?.resetMainViewController(for: 4)
        }
    }
}

extension ChangeSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell") as! SettingsTableViewCell
        cell.tag  = indexPath.row
        cell.text = texts[indexPath.row]
        cell.icon = UIImage(systemName: icons[indexPath.row])
        cell.initViews()
        cell.checkImage.image = (cell.tag == current ? UIImage(systemName: "checkmark.circle") : nil)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        changed(index: indexPath.row)
    }
}
