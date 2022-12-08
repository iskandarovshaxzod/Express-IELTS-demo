//
//  TabItemView.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 05.12.2022.
//

import UIKit

class TabItemView: UIView {
    
    let subView   = UIView()
    let imageView = UIImageView()
    let label     = UILabel()
    
    var isSelected = false{
        didSet{
            changed()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(image: UIImage?, lbl: String){
        super.init(frame: CGRect())
        
        addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(60)
        }

        subView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(25)
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
        }
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        
        subView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.bottom.greaterThanOrEqualToSuperview().offset(-5)
            make.centerX.equalToSuperview()
        }
        label.text = lbl
        label.textColor = .black
    }
    
    func changed(){
        if isSelected{
            imageView.tintColor = .red
            label.textColor     = .red
        } else {
            imageView.tintColor = .black
            label.textColor     = .black
        }
    }
    
}
