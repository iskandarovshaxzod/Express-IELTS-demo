//
//  MonthCollectionViewCell.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 12.12.2022.
//

import UIKit

class MonthCollectionViewCell: UICollectionViewCell {
    let subView = UIView()
    let label   = UILabel()
    
    var text = ""

    func initViews(){
        
        addSubview(subView)
        subView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        subView.layer.cornerRadius = 20
        subView.backgroundColor = UIColor(red: 2/255, green: 3/255, blue: 148/255, alpha: 1.0)
        
        subView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(5)
            make.right.bottom.equalToSuperview().offset(-5)
        }
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
    }
}
