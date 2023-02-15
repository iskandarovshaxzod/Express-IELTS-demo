//
//  StudentReceiptViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 09.01.2023.
//

import UIKit

class StudentReceiptViewController: BaseViewController {
    
    let subView   = UIView()
    let tableView = UITableView()
    let dateLabel = UILabel()
    let hView     = UIView()
    
    var canCall = false
    var text  = ""
    var texts = Array<(String, String)>()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initViews() {
        view.addSubview(hView)
        hView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        hView.backgroundColor = .gray.withAlphaComponent(0.4)
        hView.isUserInteractionEnabled = true
        hView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.center.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(100)
            make.bottom.lessThanOrEqualToSuperview().offset(-100)
        }
        subView.backgroundColor = "cl_cell_back".color
        subView.layer.cornerRadius = 10
        
        subView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
        }
        dateLabel.text = text
        dateLabel.textAlignment = .center
        dateLabel.numberOfLines = 0
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(min(50 * texts.count, Int(height)-250))
        }
        tableView.showsVerticalScrollIndicator = false
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }

    @objc func viewTapped() {
        dismiss(animated: false)
    }
}

extension StudentReceiptViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InfoTableViewCell
        cell.leftText  = texts[indexPath.row].0
        cell.rightText = texts[indexPath.row].1
        cell.initViews()
        cell.selectionStyle = (canCall ? .default : .none)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 2 {
            callNumber(phoneNumber: texts[2].1)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
