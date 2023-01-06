//
//  Button.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.12.2022.
//

import UIKit

class Button: UIButton {

    init(text: String){
        super.init(frame: CGRect())
        
        self.setTitle(text, for: .normal)
        self.layer.borderWidth  = 1
        self.layer.borderColor  = UIColor.red.cgColor
        self.setTitleColor(.red, for: .normal)
        self.setTitleColor(.red.withAlphaComponent(0.5), for: .highlighted)
        self.addTarget(self, action: #selector(startHighlight), for: .touchDown)
        self.addTarget(self, action: #selector(stopHighlight), for: .touchUpOutside)
//        self.addTarget(self, action: #selector(onClick), for: .touchUpInside)
    }
    
    @objc func startHighlight() {
        self.layer.borderColor = UIColor.red.withAlphaComponent(0.5).cgColor
    }
    @objc func stopHighlight() {
        self.layer.borderColor = UIColor.red.cgColor
    }
    
//    @objc func onClick(){
//        click
//    }
//
////    func click(){}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
