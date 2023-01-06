//
//  AddViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.12.2022.
//

import UIKit

class AddViewController: BaseViewController {

    let subView = UIView()
    
    let nameField = TextField(placeHolder: "")
    let addButton = Button(text: "")
    
    var nameText   = ""
    var buttonText = ""
    var navTitle   = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureNavBar() {
        title = navTitle
    }
    
    override func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = "cl_main_back".color
        subView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        
        subView.addSubview(nameField)
        nameField.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(width / 10)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        nameField.attributedPlaceholder = NSAttributedString(string: nameText,
                  attributes: [NSAttributedString.Key.foregroundColor: "cl_text_blue".color])
        nameField.layer.borderColor  = "cl_text_blue".color.cgColor
        
        subView.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-btmPadding-20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(60)
        }
        addButton.setTitle(buttonText, for: .normal)
        addButton.layer.cornerRadius = 30
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    }
    
    @objc func addTapped(){
        if navTitle == "new_teacher".localized {
            showSureInfo(title: String(format: "add_info".localized, navTitle)) {
                [weak self] alertAction in
                self?.showLoading()
                FirebaseManager.shared.addNewTeacher(teacherName: "hello 2") { err in
                    self?.hideLoading()
                    if err != nil {
                        self?.showErrorMessage(title: err?.localizedDescription)
                    } else {
                        // show success
                        print("successfully added")
                    }
                }
            }
        } else if navTitle == "new_teacher_config".localized {
            showSureInfo(title: String(format: "add_info".localized, navTitle)) {
                [weak self] alertAction in
                self?.showLoading()
                FirebaseManager.shared.addNewTeacherConfig(teacherName: "hello 2", teacherConfig: "every day 2") { err in
                    self?.hideLoading()
                    if err != nil {
                        self?.showErrorMessage(title: err?.localizedDescription)
                    } else {
                        // show success
                        print("successfully added")
                    }
                }
            }
        } else if navTitle == "new_group".localized {
            showSureInfo(title: String(format: "add_info".localized, navTitle)) {
                [weak self] alertAction in
                self?.showLoading()
                FirebaseManager.shared.addNewGroup(teacherName: "hello 2",
                                                   teacherConfig: "every day", groupName: "leaders") { err in
                    self?.hideLoading()
                    if err != nil {
                        self?.showErrorMessage(title: err?.localizedDescription)
                    } else {
                        // show success
                        print("successfully added")
                    }
                }
            }
        } else if navTitle == "new_student".localized {
            showSureInfo(title: String(format: "add_info".localized, navTitle)) {
                [weak self] alertAction in
                self?.showLoading()
                FirebaseManager.shared.addNewStudent(teacherName: "hello 2",
                                                     teacherConfig: "every day", groupName: "leaders",
                                                     studentName: "Iskandarov Shaxzod") { err in
                    self?.hideLoading()
                    if err != nil {
                        self?.showErrorMessage(title: err?.localizedDescription)
                    } else {
                        // show success
                        print("successfully added")
                    }
                }
            }
        }
    }
    
    @objc func viewTapped(){
        nameField.resignFirstResponder()
    }

}
