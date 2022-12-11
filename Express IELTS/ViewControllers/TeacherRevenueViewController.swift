//
//  TeacherRevenueViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 11.12.2022.
//

import UIKit

class TeacherRevenueViewController: BaseViewController {
    
    let subView = UIView()
    
    var teacherName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureNavBar() {
        title = teacherName
    }
    
    override func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = .systemPink
        
        
    }

}
