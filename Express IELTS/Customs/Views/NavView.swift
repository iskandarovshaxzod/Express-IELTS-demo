//
//  NavView.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 07.12.2022.
//

import UIKit

class NavView: UIView {

    let subView   = UIView()
    let imageView = UIImageView()
    let label     = UILabel()
    
    init(text: String){
        super.init(frame: CGRect())
        
        addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(60)
        }
        subView.backgroundColor = .white
        
        subView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
