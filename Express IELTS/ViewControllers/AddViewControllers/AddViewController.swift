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
            make.top.equalToSuperview().offset(width / 3)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        nameField.placeholder = nameText
        
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
        showSureInfo(title: "Make sure", message: "Are you sure that you want to add a new teacher config ?") { [weak self] alertAction in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func viewTapped(){
        nameField.resignFirstResponder()
    }

}
