//
//  ChangePassCodeViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 23.12.2022.
//

import UIKit

class ChangePassCodeViewController: BaseViewController {
    
    let presenter = UserMethodsPresenter()
    
    let subView = UIView()
    
    let userNameLabel = UILabel()
    let newPassLabel  = UILabel()
    
    let userNameField = TextField(placeHolder: "")
    let newPassField  = TextField(placeHolder: "enter_new_pass".localized)
    
    let updateButton = Button(text: "update_pass".localized)
    let eyeButton    = UIButton()
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDelegate(delegate: self)
    }

    override func configureNavBar() {
        title = user?.login.capitalized
    }
    
    override func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = "cl_main_back".color
        subView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        
        subView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(width / 10)
            make.left.equalToSuperview().offset(30)
        }
        userNameLabel.text = "UserName"
        
        subView.addSubview(userNameField)
        userNameField.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        userNameField.text = user?.login.capitalized
        userNameField.isEnabled = (user?.login != "admin")
//        userNameField.font = userNameField.font?.withSize(20)
        
        subView.addSubview(newPassLabel)
        newPassLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
        }
        newPassLabel.text = "new_pass".localized
        
        subView.addSubview(newPassField)
        newPassField.snp.makeConstraints { make in
            make.top.equalTo(newPassLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        newPassField.font      = userNameField.font?.withSize(20)
        newPassField.rightView = eyeButton
        newPassField.rightViewMode     = .always
        newPassField.isSecureTextEntry = true
        
        eyeButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        eyeButton.addTarget(self, action: #selector(eyeTapped), for: .touchUpInside)
        
        subView.addSubview(updateButton)
        updateButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-btmPadding-20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(60)
        }
        updateButton.layer.cornerRadius = 30
        updateButton.addTarget(self, action: #selector(updateTapped), for: .touchUpInside)
    }
    
    func check() -> Bool {
        guard let userNameText = userNameField.text, let passText = newPassField.text else {
            return false
        }
        if userNameText.isEmpty || passText.isEmpty {
            vibrate(for: .error)
            if userNameText.isEmpty {
                userNameField.shake(duration: 0.5)
            }
            if passText.isEmpty {
                newPassField.shake(duration: 0.5)
            }
            return false
        }
        return true
    }
    
    @objc func updateTapped(){
        if check() {
            showLoading()
            presenter.changePassword(login:    userNameField.text?.lowercased() ?? "",
                                     password: newPassField.text?.lowercased()  ?? "",
                                     userID:   user?.password ?? "")
        }
    }
    
    @objc func viewTapped(){
        userNameField.resignFirstResponder()
        newPassField.resignFirstResponder()
    }
    
    @objc func eyeTapped() {
        newPassField.isSecureTextEntry.toggle()
        eyeButton.setImage(newPassField.isSecureTextEntry ?
                           UIImage(systemName: "eye") :
                           UIImage(systemName: "eye.slash"), for: .normal)
    }
    
    func dismiss() {
        hideAnimation()
        navigationController?.popViewController(animated: true)
    }
}

extension ChangePassCodeViewController: UserMethodsDelegate {
    func onSuccessChangePassword() {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            self?.showAnimation(animationName: "success", animationMode: .playOnce) { completed in
                self?.dismiss()
            }
        }
    }
    
    func onError(error: String?) {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            self?.showErrorMessage(title: error)
        }
    }
    
    func onSuccessGetAllUsers(users: [[User]]) {}
    func onSuccessValidateUser() {}
}
