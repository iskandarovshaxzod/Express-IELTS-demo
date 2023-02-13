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
        userLabel.text = (Database.isAdmin ? "admin".localized : "reception".localized)
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
//        eyeButton.backgroundColor = .red
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
                emailfield.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
            }
            if passText.isEmpty {
                passfield.shake(duration: 0.5,  values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
            }
            return false
        }
        
        return true
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
        
        
//        showLoading()
//        //TODO: Remove DispatchQueue
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
//            self.hideLoading()
//            self.vibrate(for: .success)
//            let vc = MainTabViewController()
//            UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: vc)
//        }
        showLoading()
        presenter.validateUser(email: "admin@gmail.com", password: "1111")
    }
    
//    func validateUser(email: String, password: String) {
//        FirebaseManager.shared.validateUser(email: email, password: password,
//           success: { [weak self] in
//            self?.hideLoading()
//            self?.vibrate(for: .success)
//            self?.resetMainViewController(for: 1)
//        }, error: { [weak self] err in
//            self?.hideLoading()
//            self?.showErrorMessage(title: err?.localizedDescription)
//        })
//    }
    
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
        
//        UIView.animate(withDuration: 0.25) { [weak self] in
//            self?.eyeButton.transform = CGAffineTransform(scaleX: 0.35, y: 0.35)
//        } completion: { [weak self] _ in
//            self?.eyeButton.setImage((self?.passfield.isSecureTextEntry ?? true) ?
//                                     UIImage(systemName: "eye.slash") :
//                                     UIImage(systemName: "eye"), for: .normal)
//            self?.eyeButton.transform = CGAffineTransform.identity
//            self?.passfield.isSecureTextEntry.toggle()
//        }
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

extension AuthUserViewController: UserMethodsDelegate {
    func onSuccessValidateUser() {
        hideLoading()
        vibrate(for: .success)
        resetMainViewController(for: 1)
    }
    
    func onErrorValidateUser(error: String?) {
        hideLoading()
        showErrorMessage(title: error)
    }
    
    
    func onSuccessChangePassword(){}
    func onErrorChangePassword(error: String?){}
}
