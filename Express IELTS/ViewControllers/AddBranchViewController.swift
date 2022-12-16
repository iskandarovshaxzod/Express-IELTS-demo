//
//  AddBranchViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 07.12.2022.
//

import UIKit

class AddBranchViewController: BaseViewController {
    
    let subView = UIView()
    
    let emailfield = TextField(placeHolder: "New branch's email")
    let passfield  = TextField(placeHolder: "New branch's password")

    let addButton  = Button(text: "Add New Branch")

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureNavBar() {
        title = "New Branch"
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
            make.top.equalToSuperview().offset(width / 3)
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
        showSureInfo(title: "Continue ???", message: "Are you sure that you want to add a new branch ?") { [weak self] alertAction in
            self?.navigationController?.popViewController(animated: true)
        }
    }

    @objc func viewTapped(){
        emailfield.resignFirstResponder()
        passfield.resignFirstResponder()
    }

}
