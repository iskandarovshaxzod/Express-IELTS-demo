//
//  AuthUserViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 24.11.2022.
//

import UIKit
import SnapKit

class AuthUserViewController: BaseViewController {
    
    let subView = UIView()
    
    let emailLabel = UILabel()
    let userLabel  = UILabel()
    
    let emailfield = TextField(placeHolder: "Email")
    let passfield  = TextField(placeHolder: "Password")
    
    let btnBack = UIButton()
    let btnSubmit = Button(text: "Submit")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    override func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = .white
        subView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        
        subView.addSubview(btnBack)
        btnBack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(topPadding + 10)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(30)
        }
        btnBack.setImage(UIImage(named: "ic_cancel"), for: .normal)
        btnBack.tintColor = .gray
        btnBack.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        subView.addSubview(userLabel)
        userLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(width / 4)
            make.centerX.equalToSuperview()
        }
        userLabel.text = (Database.isAdmin ? "Admin" : "Reception")
        userLabel.font = userLabel.font.withSize(50)
        userLabel.textColor = UIColor(red: 2/255, green: 3/255, blue: 148/255, alpha: 1.0)
        
        subView.addSubview(emailfield)
        emailfield.snp.makeConstraints { make in
            make.top.equalTo(userLabel.snp.bottom).offset(45)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }

        subView.addSubview(passfield)
        passfield.snp.makeConstraints { make in
            make.top.equalTo(emailfield.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        
        subView.addSubview(btnSubmit)
        btnSubmit.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-btmPadding-20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(60)
        }
        btnSubmit.layer.cornerRadius = 30
        btnSubmit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    }
    
    @objc func submitTapped(){
//        guard let email = emailfield.text, !email.isEmpty else {
//            showMessage(title: "Error", message: "You didn't enter email")
//            return
//        }
//
//        guard let password = passfield.text, !password.isEmpty else {
//            showMessage(title: "Error", message: "You didn't enter password")
//            return
//        }
//
//        let error = FirebaseManager.validateUser(email: email, password: password)
//
//        if error != nil{
//            showMessage(title: "Login Error", message: error ?? "")
//        } else {
//            let nc = UINavigationController(rootViewController: MainTabViewController())
//            UIApplication.shared.windows.first?.rootViewController = nc
////            backTapped()
//        }
        
        let vc = MainTabViewController()
        UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: vc)
    }
    
    @objc func backTapped(){
        dismiss(animated: true)
    }
    
    @objc func viewTapped(){
        emailfield.resignFirstResponder()
        passfield.resignFirstResponder()
    }
    
//    override func closeKeyboard() {
//        btnSubmit.snp.updateConstraints { make in
//            make.bottom.equalToSuperview().offset(-btmPadding-20)
//        }
//    }
//
//    override func openKeyboard() {
//        btnSubmit.snp.updateConstraints { make in
//            make.bottom.equalToSuperview().offset(-keyboardHeight-20)
//        }
//    }
    
    

}