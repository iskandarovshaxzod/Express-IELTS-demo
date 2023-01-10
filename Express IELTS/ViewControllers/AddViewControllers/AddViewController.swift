//
//  AddViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.12.2022.
//

import UIKit

class AddViewController: BaseViewController {
    
    let presenter = AddMethodsPresenter()

    let subView   = UIView()
    let nameField = TextField(placeHolder: "")
    let addButton = Button(text: "")
    var picker    = UIButton()
    
    var nameText   = ""
    var buttonText = ""
    var navTitle   = ""
    var groupType: GroupType?

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
        
        subView.addSubview(picker)
        picker.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        picker.setTitle("Type", for: .normal)
        picker.setTitleColor("cl_text_blue".color, for: .normal)
        picker.layer.cornerRadius = 20
        picker.backgroundColor = "cl_cell_back".color
        picker.isHidden = (navTitle != "new_group".localized)
        
        
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
        
        configurePicker()
    }
    
    func configurePicker() {
        var menuItems: [UIAction] {
            var actions = [UIAction]()
            GroupType.allCases.forEach({ type in
                actions.append(UIAction(title: "\(type.rawValue)",
                                        image: UIImage(systemName: "\(type.rawValue).square"),
                                        handler: { [weak self] (_) in
                    self?.groupType = type
                    self?.picker.setTitle("Type: \(type.rawValue)", for: .normal)
                }))
            })
            return actions
        }
        let menu    = UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        picker.menu = menu
        picker.showsMenuAsPrimaryAction = true
    }
    
    func check() -> Bool {
        guard let text = nameField.text else {
            return false
        }
        
        if text.isEmpty || (navTitle == "new_group".localized && groupType == nil) {
            vibrate(for: .error)
            if text.isEmpty {
                nameField.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
            }
            if navTitle == "new_group".localized && groupType == nil {
                picker.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
            }
            return false
        }
        
        return true
    }
    
    @objc func addTapped(){
        if check() {
            showSureInfo(title: String(format: "add_info".localized, navTitle)) {
                [weak self] alertAction in
                self?.showLoading()
                if self?.navTitle        == "new_teacher".localized {
                    self?.presenter.addNewTeacher(teacherName: self?.nameField.text?.lowercased() ?? "")
                } else if self?.navTitle == "new_teacher_config".localized {
                    self?.presenter.addNewTeacherConfig(configName: self?.nameField.text?.lowercased() ?? "")
                } else if self?.navTitle == "new_group".localized {
                    self?.presenter.addNewGroup(groupName: self?.nameField.text?.lowercased() ?? "",
                                                groupType: self?.groupType ?? .twelve)
                } else if self?.navTitle == "new_student".localized {
                    self?.presenter.addNewStudent(studentName: self?.nameField.text?.lowercased() ?? "")
                }
            }
        }
    }
    
    @objc func viewTapped(){
        nameField.resignFirstResponder()
    }
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
}

extension AddViewController: AddMethodsDelegate {
    func onSuccessAddNewTeacher() {
        hideLoading()
        dismiss()
    }
    
    func onSuccessAddNewTeacherConfig() {
        hideLoading()
        dismiss()
    }
    
    func onSuccessAddNewGroup() {
        hideLoading()
        dismiss()
    }
    
    func onSuccessAddNewStudent() {
        hideLoading()
        dismiss()
    }
    
    func onErrorAddNew(error: String?) {
        print(error)
        hideLoading()
        showErrorMessage(title: error)
    }
}
