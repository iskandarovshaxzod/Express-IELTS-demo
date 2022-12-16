//
//  TotalRevenueView.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 11.12.2022.
//

import UIKit

class TotalRevenueView: UIView {
    
    let subView = UIView()
    
    let nameLabel = UILabel()
    let sumLabel  = UILabel()

    init() {
        super.init(frame: CGRect())
        
        addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = UIColor(red: 2/255, green: 3/255, blue: 148/255, alpha: 1.0)
        subView.layer.cornerRadius = 15
        subView.backgroundColor = "cl_text_blue".color
        
        subView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.textColor = .white
        
        subView.addSubview(sumLabel)
        sumLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        sumLabel.numberOfLines = 0
        sumLabel.textAlignment = .center
        sumLabel.font = sumLabel.font.withSize(22)
        sumLabel.textColor = .white
    }
    
    func updateTexts(text: String, sum: String) {
        nameLabel.text = text
        sumLabel.text  = sum  + " sum"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
