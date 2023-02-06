//
//  AddBranchViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 07.12.2022.
//

import UIKit

class AddBranchViewController: BaseViewController {
    
    let subView = UIView()
    
    let emailfield = TextField(placeHolder: "new_branch_mail".localized)
    let passfield  = TextField(placeHolder: "new_branch_pass".localized)

    let addButton  = Button(text: "new_branch_add".localized)

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureNavBar() {
        title = "new_branch".localized
    }

    override func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = "cl_main_back".color
        subView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))

        subView.addSubview(emailfield)
        emailfield.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(width / 10)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }

        subView.addSubview(passfield)
        passfield.snp.updateConstraints { make in
            make.top.equalTo(emailfield.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        passfield.keyboardType = .numberPad

        subView.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-btmPadding-20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(60)
        }
        addButton.layer.cornerRadius = 30
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)

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

    @objc func addTapped(){
        if check() {
            showSureInfo(title: "new_branch_add_info".localized) { [weak self] alertAction in
                self?.showLoading()
                FirebaseManager.shared.addNewBranch(email:    self?.emailfield.text?.lowercased() ?? "",
                                                    password: self?.passfield.text?.lowercased()  ?? "") {
                    self?.hideLoading()
                    self?.showAnimation(animationName: "success", animationMode: .playOnce) { _ in
                        self?.dismiss()
                    }
                } error: { err in
                    self?.hideLoading()
                    self?.showErrorMessage(title: err?.localizedDescription)
                }
            }
        }
    }

    @objc func viewTapped(){
        emailfield.resignFirstResponder()
        passfield.resignFirstResponder()
    }
    
    func dismiss() {
        hideAnimation()
        navigationController?.popViewController(animated: true)
    }

}
