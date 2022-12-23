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
                case 0: Database.shared.language = .english
                case 1: Database.shared.language = .russian
                case 2: Database.shared.language = .uzbek
                default: break
            }
        } else {
            switch index {
                case 0: Database.shared.userMode = .system
                case 1: Database.shared.userMode = .dark
                case 2: Database.shared.userMode = .light
                default: break
            }
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
        if let cells = tableView.visibleCells as? [SettingsTableViewCell] {
            cells.forEach { cell in
                cell.isSelect = (cell.tag == indexPath.row)
            }
        }
    }
}
