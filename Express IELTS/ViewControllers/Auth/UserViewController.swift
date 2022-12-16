//
//  UserViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 23.11.2022.
//

import UIKit
import SnapKit
import FirebaseFirestore

class UserViewController: BaseViewController {
    
    let subView = UIView()
    
    let adminBtn = UIButton()
    let recBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = "cl_main_back".color
        
        subView.addSubview(adminBtn)
        adminBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(subView.snp.centerX).offset(-15)
            make.centerY.equalToSuperview()
            make.height.equalTo(70)
        }
        adminBtn.setTitle("Admin", for: .normal)
        adminBtn.setTitleColor(.red, for: .normal)
        adminBtn.setTitleColor(.red.withAlphaComponent(0.6), for: .highlighted)
        adminBtn.layer.borderWidth = 2
        adminBtn.layer.borderColor = UIColor.red.cgColor
        adminBtn.layer.cornerRadius = 35
        adminBtn.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        adminBtn.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        adminBtn.addTarget(self, action: #selector(startHighlight), for: .touchDown)
        adminBtn.addTarget(self, action: #selector(stopHighlight), for: .touchUpOutside)
    
        subView.addSubview(recBtn)
        recBtn.snp.makeConstraints { make in
            make.left.equalTo(subView.snp.centerX).offset(15)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.height.equalTo(70)
        }
        recBtn.setTitle("Reception", for: .normal)
        recBtn.setTitleColor(.red, for: .normal)
        recBtn.setTitleColor(.red.withAlphaComponent(0.6), for: .highlighted)
        recBtn.layer.borderWidth = 2
        recBtn.layer.borderColor = UIColor.red.cgColor
        recBtn.layer.cornerRadius = 35
        recBtn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        recBtn.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        recBtn.addTarget(self, action: #selector(startHighlight), for: .touchDown)
        recBtn.addTarget(self, action: #selector(stopHighlight), for: .touchUpOutside)
    }

    
    @objc func tapped(_ button: UIButton){
        button.layer.borderColor = UIColor.red.withAlphaComponent(0.6).cgColor
        let vc = AuthUserViewController()
        Database.shared.isAdmin = false
        if button == adminBtn{
            Database.shared.isAdmin = true
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func startHighlight(sender: UIButton) {
        sender.layer.borderColor = UIColor.red.withAlphaComponent(0.5).cgColor
    }
    @objc func stopHighlight(sender: UIButton) {
        sender.layer.borderColor = UIColor.red.cgColor
    }
}
