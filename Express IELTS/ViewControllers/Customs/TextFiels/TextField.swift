//
//  TextField.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.12.2022.
//

import UIKit

class TextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeHolder: String){
        super.init(frame: CGRect())
        self.clearButtonMode = .whileEditing
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 2/255, green: 3/255, blue: 148/255, alpha: 1.0).cgColor
        self.layer.cornerRadius = 5
        self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 2/255, green: 3/255, blue: 148/255, alpha: 0.4)])
        self.setLeftPadding(inset: 10)
    }

}
