//
//  InfoTableViewCell.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 11.02.2023.
//

import UIKit

class InfoTableViewCell: BaseTableViewCell {
    
    let subView    = UIView()
    let leftLabel  = UILabel()
    let rightLabel = UILabel()
    
    var leftText   = ""
    var rightText  = ""

    func initViews() {
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(leftLabel)
        leftLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(width/2-35)
        }
        leftLabel.numberOfLines = 0
        leftLabel.text = leftText
        leftLabel.textAlignment = .left
     
        subView.addSubview(rightLabel)
        rightLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(width/2-35)
        }
        rightLabel.numberOfLines = 0
        rightLabel.text = rightText
        rightLabel.textAlignment = .right
    }
}
