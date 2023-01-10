//
//  StudentReceiptViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 09.01.2023.
//

import UIKit

class StudentReceiptViewController: BaseViewController {
    
    let subView = UIView()
    let dateLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initViews() {
        view.backgroundColor = .gray.withAlphaComponent(0.4)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.centerY.equalToSuperview()
            make.height.equalTo(200)
        }
        subView.backgroundColor = "cl_cell_back".color
        subView.layer.cornerRadius = 10
        
        subView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
        }
        dateLabel.text = "Payment dates"
        dateLabel.textAlignment = .center
        dateLabel.numberOfLines = 0
    }

    @objc func viewTapped() {
        dismiss(animated: false)
    }
}
