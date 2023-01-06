//
//  CheckBoxButton.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 25.12.2022.
//

import UIKit

class CheckBoxButton: UIButton {
    init(){
        super.init(frame: CGRect())
    }
    
    @objc func startHighlight() {
        self.layer.borderColor = UIColor.red.withAlphaComponent(0.5).cgColor
    }
    @objc func stopHighlight() {
        self.layer.borderColor = UIColor.red.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
