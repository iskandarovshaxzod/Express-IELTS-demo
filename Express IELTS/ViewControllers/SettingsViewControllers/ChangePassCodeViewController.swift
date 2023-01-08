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
    
    let oldPassLabel = UILabel()
    let newPassLabel = UILabel()
    
    let oldPassField = TextField(placeHolder: "")
    let newPassField = TextField(placeHolder: "enter_new_pass".localized)
    
    let updateButton = Button(text: "update_pass".localized)
    let eyeButton    = UIButton()
    
    var isSecure = true
    var user: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDelegate(delegate: self)
    }

    override func configureNavBar() {
        title = user?.name.capitalized
    }
    
    override func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = "cl_main_back".color
        subView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        
        subView.addSubview(oldPassLabel)
        oldPassLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(width / 10)
            make.left.equalToSuperview().offset(30)
        }
        oldPassLabel.text = "old_pass".localized
        
        subView.addSubview(oldPassField)
        oldPassField.snp.makeConstraints { make in
            make.top.equalTo(oldPassLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        oldPassField.isEnabled = false
        oldPassField.text = "****"
        oldPassField.font = oldPassField.font?.withSize(20)
        
        subView.addSubview(eyeButton)
        eyeButton.snp.makeConstraints { make in
            make.centerY.equalTo(oldPassField)
            make.right.equalToSuperview().offset(-30)
            make.width.height.equalTo(50)
        }
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        eyeButton.addTarget(self, action: #selector(eyeTapped), for: .touchUpInside)
        
        subView.addSubview(newPassLabel)
        newPassLabel.snp.makeConstraints { make in
            make.top.equalTo(oldPassField.snp.bottom).offset(30)
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
        newPassField.font = oldPassField.font?.withSize(20)
        
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
    
    @objc func updateTapped(){
        showLoading()
        presenter.changePassword(email: user?.name ?? "admin", password: "aaaa")
    }
    
    @objc func viewTapped(){
        oldPassField.resignFirstResponder()
        newPassField.resignFirstResponder()
    }
    
    @objc func eyeTapped() {
        isSecure.toggle()
        
//        UIView.animate(withDuration: 0.35) { [weak self] in
//            self?.eyeButton.transform = CGAffineTransform(scaleX: 0.35, y: 0.35)
//        } completion: { [weak self] _ in
//            if self?.isSecure ?? true {
//                self?.eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
//                self?.oldPassField.text = "****"
//            } else {
//                self?.eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
//                self?.oldPassField.text = "2222"
//            }
//            self?.eyeButton.transform = CGAffineTransform.identity
//        }
        
        if isSecure {
            eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
            oldPassField.text = "****"
        } else {
            eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            oldPassField.text = user?.password
        }
    }
}

extension ChangePassCodeViewController: UserMethodsDelegate {
    func onSuccessChangePassword() {
        hideLoading()
        // TODO: show success animation
    }
    
    func onErrorChangePassword(error: String?) {
        hideLoading()
        showErrorMessage(title: error)
    }
    
    func onSuccessValidateUser(){}
    
    func onErrorValidateUser(error: String?){}
}
