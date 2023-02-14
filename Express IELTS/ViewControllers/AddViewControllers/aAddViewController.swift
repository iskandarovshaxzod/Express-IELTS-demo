//
//  aAddViewViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 13.02.2023.
//

import UIKit

class aAddViewController: BaseViewController {
    
    let addPresenter  = AddMethodsPresenter()
//    let editPresenter = AddMethodsPresenter()
    
    let subView     = UIView()
    let firstField  = TextField(placeHolder: "firstField")
    let secondField = TextField(placeHolder: "secondField")
    let addButton   = Button(text: "")
    var picker      = UIButton()
    
    var navTitle   = ""
    var addBtnText = ""
    var groupType: GroupType?
    var firstFieldText: String?
    var secondFieldText: String?
    var firstFieldPlaceholder = ""
    var secondFieldPlaceholder: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePicker()
        addPresenter.setDelegate(delegate: self)
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
        
        subView.addSubview(firstField)
        firstField.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(width / 10)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        firstField.placeholder = firstFieldPlaceholder
//        firstField.text =
        
        subView.addSubview(secondField)
        secondField.snp.updateConstraints { make in
            make.top.equalTo(firstField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        secondField.keyboardType = .numberPad
        secondField.placeholder  = secondFieldPlaceholder
        secondField.isHidden = (secondFieldPlaceholder == nil)
        
        subView.addSubview(picker)
        picker.snp.makeConstraints { make in
            make.top.equalTo(firstField.snp.bottom).offset(20)
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
        addButton.layer.cornerRadius = 30
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        addButton.setTitle(addBtnText, for: .normal)
    }
    
    @objc func addTapped(){
        if check() {
            showSureInfo(title: String(format: "add_info".localized, navTitle)) {
                [weak self] (_) in
                self?.showLoading()
                if self?.navTitle        == "new_branch".localized {
                    let branch = Branch(branchName: self?.firstField.text ?? "",
                                  password:   self?.secondField.text ?? "")
                    self?.addPresenter.addBranch(stringURL: Constants.BASE_URL + Constants.BRANCH_ADD,
                                              body: branch)
                } else if self?.navTitle == "new_teacher".localized {
                    let teacher = Teacher(teacherName: self?.firstField.text ?? "",
                                          branch: BranchID(id: UUID(uuidString: Database.shared.branchID)))
                    self?.addPresenter.addTeacher(stringURL: Constants.BASE_URL + Constants.TEACHER_ADD,
                                               body: teacher)
                } else if self?.navTitle == "new_teacher_config".localized {
                    let config = Config(configName: self?.firstField.text ?? "",
                                        teacher: TeacherID(id: UUID(uuidString: Database.shared.teacherID)))
                    self?.addPresenter.addTeacherConfig(stringURL: Constants.BASE_URL + Constants.CONFIG_ADD,
                                                    body: config)
                } else if self?.navTitle == "new_group".localized {
                    let group = Group(groupName: self?.firstField.text ?? "",
                                      groupType: "twelve",
                                      config: ConfigID(id: UUID(uuidString: Database.shared.configID)))
                    self?.addPresenter.addGroup(stringURL: Constants.BASE_URL + Constants.GROUP_ADD,
                                             body: group)
                } else if self?.navTitle == "new_student".localized {
                    let student = Student(studentName: self?.firstField.text ?? "",
                                          phoneNumber: self?.secondField.text ?? "",
                                          group: GroupID(id: UUID(uuidString: Database.shared.groupID)),
                                          branch: BranchID(id: UUID(uuidString: Database.shared.branchID)))
                    self?.addPresenter.addStudent(stringURL: Constants.BASE_URL + Constants.STUDENT_ADD,
                                        body: student)
                }
            }
        }
    }
    
    @objc func viewTapped(){
        firstField.resignFirstResponder()
        secondField.resignFirstResponder()
    }
    
    func dismiss() {
        hideAnimation()
        navigationController?.popViewController(animated: true)
    }
    
    func check() -> Bool {
        guard let firstText = firstField.text else {
            return false
        }
        
        if firstText.isEmpty || (secondFieldPlaceholder != nil && secondField.text?.isEmpty ?? false) ||
            (navTitle == "new_group".localized && groupType == nil) {
            vibrate(for: .error)
            if firstText.isEmpty {
                firstField.shake(duration: 0.5)
            }
            if (secondFieldPlaceholder != nil && secondField.text?.isEmpty ?? false) {
                secondField.shake(duration: 0.5)
            }
            if navTitle == "new_group".localized && groupType == nil {
                picker.shake(duration: 0.5)
            }
            return false
        }
        
        return true
    }
    
    func configurePicker() {
        var menuItems: [UIAction] {
            var actions = [UIAction]()
            GroupType.allCases.forEach({ type in
                actions.append(UIAction(title: "\(type.rawValue)",
                                        image: UIImage(systemName: "\(type.rawValue).square"),
                                        handler: {
                [weak self] (_) in
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
}

extension aAddViewController: AddMethodsDelegate {
    func onSuccessAddNew() {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            self?.showAnimation(animationName: "success", animationMode: .playOnce) { [weak self] _ in
                self?.dismiss()
            }
        }
    }
    
    func onErrorAddNew(error: String?) {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            self?.showErrorMessage(title: error)
        }
    }
}
