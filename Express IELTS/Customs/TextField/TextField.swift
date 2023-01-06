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
        self.layer.borderWidth  = 1
        self.layer.borderColor  = "cl_text_blue".color.cgColor
        self.layer.cornerRadius = 5
        self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: "cl_text_blue".color])
        self.setLeftPadding(inset: 10)
    }

}
