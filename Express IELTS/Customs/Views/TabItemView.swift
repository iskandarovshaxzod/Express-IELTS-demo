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
        imageView.contentMode = .scaleAspectFit//59 130 247
        imageView.tintColor = UIColor(red: 146/255, green: 146/255, blue: 152/255, alpha: 1.0)
        
        subView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.bottom.greaterThanOrEqualToSuperview().offset(-5)
            make.centerX.equalToSuperview()
        }
        label.text = lbl
        label.textColor = UIColor(red: 146/255, green: 146/255, blue: 152/255, alpha: 1.0)
    }
    
    func changed(){
        
        if isSelected{
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.imageView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                self?.imageView.tintColor = "cl_text_blue".color
                self?.label.textColor     = "cl_text_blue".color
            } completion: { [weak self] _ in
                self?.imageView.transform = CGAffineTransform.identity
            }
//            imageView.tintColor = "cl_text_blue".color
//            label.textColor     = "cl_text_blue".color
        } else {
            imageView.tintColor = UIColor(red: 146/255, green: 146/255, blue: 152/255, alpha: 1.0) //.black
            label.textColor     = UIColor(red: 146/255, green: 146/255, blue: 152/255, alpha: 1.0) //.black
        }
    }
    
}
