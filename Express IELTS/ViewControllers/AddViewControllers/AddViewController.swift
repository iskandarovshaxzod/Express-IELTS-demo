//
//  AddViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.12.2022.
//

import UIKit

class AddViewController: BaseViewController {
    
    let presenter = AddMethodsPresenter()

    let subView = UIView()
    
    let nameField = TextField(placeHolder: "")
    let addButton = Button(text: "")
    
    var nameText   = ""
    var buttonText = ""
    var navTitle   = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDelegate(delegate: self)
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
        showSureInfo(title: String(format: "add_info".localized, navTitle)) {
            [weak self] alertAction in
            self?.showLoading()
            if self?.navTitle == "new_teacher".localized {
                self?.presenter.addNewTeacher(teacherName: "teacher name")
            } else if self?.navTitle == "new_teacher_config".localized {
                self?.presenter.addNewTeacherConfig(configName: "config name")
            } else if self?.navTitle == "new_group".localized {
                self?.presenter.addNewGroup(groupName: "group name")
            } else if self?.navTitle == "new_student".localized {
                self?.presenter.addNewStudent(studentName: "student name")
            }
        }
    }
    
    @objc func viewTapped(){
        nameField.resignFirstResponder()
    }

}

extension AddViewController: AddMethodsDelegate {
    func onSuccessAddNewTeacher() {
        hideLoading()
    }
    
    func onSuccessAddNewTeacherConfig() {
        hideLoading()
    }
    
    func onSuccessAddNewGroup() {
        hideLoading()
    }
    
    func onSuccessAddNewStudent() {
        hideLoading()
    }
    
    func onErrorAddNew(error: String?) {
        hideLoading()
        showErrorMessage(title: error)
    }
}
