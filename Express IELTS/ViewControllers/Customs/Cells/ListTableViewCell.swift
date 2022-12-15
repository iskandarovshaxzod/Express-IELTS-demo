//
//  ListTableViewCell.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.12.2022.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    let subView = UIView()
    let label   = UILabel()
    
    var text = ""

    func initViews(){
        addSubview(subView)
        subView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        subView.layer.cornerRadius  = 20
        subView.backgroundColor     = .white //UIColor(red: 253/255, green: 255/255, blue: 245/255, alpha: 0.6)
        subView.layer.shadowColor   = UIColor(red: 2/255, green: 3/255, blue: 148/255, alpha: 1.0).cgColor
        subView.layer.shadowOpacity = 0.6
        subView.layer.shadowOffset  = .zero
        subView.layer.shadowRadius  = 2

        subView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(5)
            make.right.bottom.equalToSuperview().offset(-5)
        }
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
    }
}
