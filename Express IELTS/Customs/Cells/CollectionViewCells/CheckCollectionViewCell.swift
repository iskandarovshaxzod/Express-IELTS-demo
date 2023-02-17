//
//  CheckCollectionViewCell.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 25.12.2022.
//

import UIKit

class CheckCollectionViewCell: BaseCollectionViewCell {
    
    let subView  = UIView()
    let checkBtn = CheckBoxButton()
    
    var isChecked = false

    func initViews(){
        
        addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = "cl_text_blue".color
        
        subView.addSubview(checkBtn)
        checkBtn.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.center.equalToSuperview()
        }
        checkBtn.addTarget(self, action: #selector(checkTapped), for: .touchUpInside)
        checkBtn.backgroundColor    = UIColor(red: 186/255, green: 224/255, blue: 189/255, alpha: 1)
        checkBtn.layer.cornerRadius = 25
        checkBtn.layer.borderWidth  = 1
        checkBtn.layer.borderColor  = UIColor(red: 94/255, green: 156/255, blue: 118/255, alpha: 1).cgColor
        
        checkTapped()
    }
    
    @objc func checkTapped() {
        if Database.shared.canCheck {
            isChecked.toggle()
            UIView.animate(withDuration: 0.4) { [weak self] in
                self?.checkBtn.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            } completion: { [weak self] _ in
                if self?.isChecked ?? true {
                    self?.checkBtn.setImage(UIImage(named: "check"), for: .normal)
                } else {
                    self?.checkBtn.setImage(nil, for: .normal)
                }
                self?.checkBtn.transform = CGAffineTransform.identity
            }
        }
    }
}
