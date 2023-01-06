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

    @objc func addTapped(){
        showSureInfo(title: "new_branch_add_info".localized) { [weak self] alertAction in
            self?.showLoading()
            FirebaseManager.shared.addNewBranch(email: "novza", password: "123456") { err in
                self?.hideLoading()
                if err != nil {
                    self?.showErrorMessage(title: err?.localizedDescription)
                } else {
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

    @objc func viewTapped(){
        emailfield.resignFirstResponder()
        passfield.resignFirstResponder()
    }

}
