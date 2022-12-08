//
//  MonthlyPaymentViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.12.2022.
//

import UIKit

class MonthlyPaymentViewController: BaseViewController {
    
    let subView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureNavBar() {
        
    }
    
    override func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = .systemPink
        
        
        
    }

}
