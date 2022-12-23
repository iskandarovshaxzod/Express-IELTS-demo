//
//  SettingsTableViewCell.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 22.12.2022.
//

import UIKit

class SettingsTableViewCell: BaseTableViewCell {
    
    let subView = UIView()
    let label   = UILabel()
    let image   = UIImageView()
    let checkImage = UIImageView()
    
    var icon: UIImage? = UIImage()
    var text = ""
    var isSelect = false{
        didSet{
            changed()
        }
    }

    func initViews() {
        addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = "cl_cell_back".color
        
        subView.addSubview(image)
        image.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(25)
        }
        image.image = icon
        image.contentMode = .scaleAspectFit
        
        subView.addSubview(checkImage)
        checkImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(25)
        }
        checkImage.contentMode = .scaleAspectFit
        
        subView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(15)
            make.right.equalTo(checkImage.snp.left).offset(-15)
            make.centerY.equalToSuperview()
        }
        label.text = text
        label.textAlignment = .center
    }

    func changed() {
        if isSelect {
            checkImage.image = UIImage(systemName: "checkmark.circle")
        } else {
            checkImage.image = nil
        }
    }
}
