//
//  ListTableViewCell.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.12.2022.
//

import UIKit

class ListTableViewCell: BaseTableViewCell {
    
    let hView   = UIView()
    let subView = UIView()
    let label   = UILabel()
    
    var text = ""

    func initViews(){
        
        contentView.backgroundColor = "cl_main_back".color
        contentView.addSubview(hView)
        hView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        hView.backgroundColor = "cl_main_back".color
        
        hView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        subView.layer.cornerRadius  = 20
        subView.backgroundColor     = "cl_cell_back".color

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
