//
//  AuthUserViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 24.11.2022.
//

import UIKit
import SnapKit

class AuthUserViewController: BaseViewController {
    
    let presenter = UserMethodsPresenter()
    
    let subView = UIView()
    
    let emailLabel = UILabel()
    let userLabel  = UILabel()
    
    let emailfield = TextField(placeHolder: "email".localized)
    let passfield  = TextField(placeHolder: "password".localized)
    
    let btnBack   = UIButton()
    let eyeButton = UIButton()
    let btnSubmit = Button(text: "enter".localized)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDelegate(delegate: self)
    }
        
    override func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = "cl_main_back".color
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
        userLabel.text = (Database.shared.isAdmin ? "admin".localized : "reception".localized)
        userLabel.font = userLabel.font.withSize(50)
        userLabel.textColor = "cl_text_blue".color
        
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
        passfield.isSecureTextEntry = true
        passfield.clearButtonMode = .never
        passfield.rightView = eyeButton
        passfield.rightViewMode = .whileEditing
        
        eyeButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        eyeButton.addTarget(self, action: #selector(eyeTapped), for: .touchUpInside)
        
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
    
    func check() -> Bool {
        guard let emailText = emailfield.text, let passText = passfield.text else {
            return false
        }
        if emailText.isEmpty || passText.isEmpty {
            vibrate(for: .error)
            if emailText.isEmpty {
                emailfield.shake(duration: 0.5)
            }
            if passText.isEmpty {
                passfield.shake(duration: 0.5)
            }
            return false
        }
        return true
    }
    
    @objc func submitTapped(){
//        if check() {
            showLoading()
            presenter.validateUser(login: "admin", password: "12345")
//        }
    }
    
    
    @objc func backTapped(){
        dismiss(animated: true)
    }
    
    @objc func viewTapped(){
        emailfield.resignFirstResponder()
        passfield.resignFirstResponder()
    }
    
    @objc func eyeTapped() {
        passfield.isSecureTextEntry.toggle()
        eyeButton.setImage(passfield.isSecureTextEntry ?
                           UIImage(systemName: "eye") :
                           UIImage(systemName: "eye.slash"), for: .normal)
    }
}

extension AuthUserViewController: UserMethodsDelegate {
    
    func onSuccessValidateUser() {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            self?.vibrate(for: .success)
            self?.resetMainViewController(for: 1)
        }
    }
    
    func onError(error: String?) {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            self?.vibrate(for: .error)
            self?.showErrorMessage(title: error)
        }
    }
    
    func onSuccessGetAllUsers(users: [[User]]) {}
    func onSuccessChangePassword() {}
}
