//
//  MainTabViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 05.12.2022.
//

import UIKit

class MainTabViewController: BaseViewController {
    
    var subView  = UIView()
    let tabView  = UIView()
    let lineView = UIView()
    
    let mainItem     = TabItemView(image: UIImage(named: "ic_menu"), lbl: "Main")
    let paymentItem  = TabItemView(image: UIImage(named: "ic_payment"), lbl: "Payment")
    let studentsItem = TabItemView(image: UIImage(named: "ic_students"), lbl: "Students")
    let settingsItem = TabItemView(image: UIImage(named: "ic_settings"), lbl: "Settings")
    
    var mainController     = MainViewController()
    var paymentController  = PaymentViewController()
    var studentsController = StudentsViewController()
    var settingsController = SettingsViewController()

    var isAdmin = Database.isAdmin
    var currentTab = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureNavBar() {
        switch currentTab{
            case 1:
                navigationItem.title = "Express IELTS"
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                    target: self, action: #selector(addTapped))
                if !Database.isAdmin{
                    navigationItem.rightBarButtonItem = nil
                }
//            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "logo"),
//                                                               style: .done,
//                                                               target: self, action: #selector(addTapped))
//            let logo = UIImageView(image: UIImage(named: "logo"))
//            logo.frame = CGRect(x: 100, y: 100, width: 40, height: 40)
////            logo.frame.size = CGSize(width: 30, height: 30)
//            logo.contentMode = .scaleAspectFit
//            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logo)
            
            case 2:
                navigationItem.title = "All Payments"
                navigationItem.rightBarButtonItem = nil
            case 3:
                navigationItem.title = "All Students"
                navigationItem.rightBarButtonItem = nil
            case 4:
                navigationItem.title = "Settings"
                navigationItem.rightBarButtonItem = nil
            default:
                break
        }
    }
    
    
    override func initViews() {
        view.backgroundColor = .white
        
        view.addSubview(tabView)
        tabView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-btmPadding)
            make.height.equalTo(60)
        }
        tabView.backgroundColor = .white
        
        view.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.bottom.equalTo(tabView.snp.top)
            make.right.left.equalToSuperview()
            make.height.equalTo(1)
        }
        lineView.backgroundColor = .black
        
        
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(lineView.snp.top)
        }
        
        self.addChild(mainController)
        self.addChild(paymentController)
        self.addChild(studentsController)
        self.addChild(settingsController)
        
        subView.addSubview(mainController.view)
        mainController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(paymentController.view)
        paymentController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(studentsController.view)
        studentsController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(settingsController.view)
        settingsController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        configureTabItems()
    }
    
    func configureTabItems() {
        tabView.addSubview(mainItem)
        mainItem.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(isAdmin ? width / 4 : width / 3)
        }
        mainItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tabItemTapped)))
        
        tabView.addSubview(paymentItem)
        paymentItem.snp.makeConstraints { make in
            make.left.equalTo(mainItem.snp.right)
            make.width.equalTo(isAdmin ? width / 4 : width / 3)
        }
        paymentItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tabItemTapped)))
        
        tabView.addSubview(settingsItem)
        settingsItem.snp.makeConstraints { make in
            make.width.equalTo(isAdmin ? width / 4 : width / 3)
        }
        settingsItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tabItemTapped(_:))))
        
        if isAdmin {
            tabView.addSubview(studentsItem)
            studentsItem.snp.makeConstraints { make in
                make.left.equalTo(paymentItem.snp.right)
                make.width.equalTo(isAdmin ? width / 4 : width / 3)
            }
            studentsItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tabItemTapped)))
            
            settingsItem.snp.makeConstraints { make in
                make.left.equalTo(studentsItem.snp.right)
            }
            
        } else {
            settingsItem.snp.makeConstraints { make in
                make.left.equalTo(paymentItem.snp.right)
            }
        }
        
        changeTab()
    }
    
    @objc func tabItemTapped(_ sender: UITapGestureRecognizer){
        switch sender.view{
            case mainItem:
                currentTab = 1
            case paymentItem:
                currentTab = 2
            case studentsItem:
                currentTab = 3
            case settingsItem:
                currentTab = 4
            default:
                break
        }
        changeTab()
    }
    
    func changeTab() {
        configureNavBar()
        
        mainItem.isSelected     = (currentTab == 1)
        paymentItem.isSelected  = (currentTab == 2)
        studentsItem.isSelected = (currentTab == 3)
        settingsItem.isSelected = (currentTab == 4)

        mainController.view.isHidden     = (currentTab != 1)
        paymentController.view.isHidden  = (currentTab != 2)
        studentsController.view.isHidden = (currentTab != 3)
        settingsController.view.isHidden = (currentTab != 4)
    }
    
    @objc func addTapped(){
        navigationController?.pushViewController(AddBranchViewController(), animated: true)
    }
    
}