//
//  TeacherViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.12.2022.
//

import UIKit

class TeacherViewController: BaseViewController {
    
    let subView = UIView()
    
    let tableView = UITableView()
    
    var teacherName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureNavBar() {
        title = teacherName
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self, action: #selector(addTapped))
    }
    
    override func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = .yellow
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.backgroundColor = .blue
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        
    }
    
    @objc func addTapped() {
        let vc = AddViewController()
        vc.navTitle   = "New teacher config"
        vc.buttonText = "Add"
        vc.nameText   = "New config name"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension TeacherViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        cell.text = "config \(indexPath.row + 1)"
        cell.initViews()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = GroupViewController()
        vc.configName = "Config name \(indexPath.row + 1)"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
