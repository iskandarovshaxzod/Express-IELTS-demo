//
//  PasswordViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 23.11.2022.
//

import UIKit
import SnapKit

class PasswordViewController: BaseViewController {
    
    let subView = UIView()
    
    let pinLabel = UILabel()
    
    let password1 = UIView()
    let password2 = UIView()
    let password3 = UIView()
    let password4 = UIView()
    
    let btn0 = UIButton()
    let btn1 = UIButton()
    let btn2 = UIButton()
    let btn3 = UIButton()
    let btn4 = UIButton()
    let btn5 = UIButton()
    let btn6 = UIButton()
    let btn7 = UIButton()
    let btn8 = UIButton()
    let btn9 = UIButton()
    let btnClear = UIButton()
    let btnBack = UIButton()
    
    var counter = 0
    var password = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        subView.backgroundColor = .white
        
        subView.addSubview(btnBack)
        btnBack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(topPadding + 10)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(30)
        }
        btnBack.setImage(UIImage(named: "ic_cancel"), for: .normal)
        btnBack.tintColor = .gray
        btnBack.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        subView.addSubview(pinLabel)
        pinLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(width / 5)
            make.centerX.equalToSuperview()
        }
        pinLabel.text = "Enter pin-code"
        
        subView.addSubview(password2)
        password2.snp.makeConstraints { make in
            make.top.equalTo(pinLabel.snp.bottom).offset(20)
            make.right.equalTo(subView.snp.centerX).offset(-10)
            make.width.height.equalTo(width / 11)
        }
        password2.layer.cornerRadius = width / 22
        password2.layer.borderWidth = 2
        password2.layer.borderColor = UIColor.blue.cgColor
        
        subView.addSubview(password1)
        password1.snp.makeConstraints { make in
            make.top.equalTo(password2.snp.top)
            make.right.equalTo(password2.snp.left).offset(-20)
            make.width.height.equalTo(width / 11)
        }
        password1.layer.cornerRadius = width / 22
        password1.layer.borderColor = UIColor.blue.cgColor
        password1.layer.borderWidth = 2
        
        
        subView.addSubview(password3)
        password3.snp.makeConstraints { make in
            make.top.equalTo(password2.snp.top)
            make.left.equalTo(subView.snp.centerX).offset(10)
            make.width.height.equalTo(width / 11)
        }
        password3.layer.cornerRadius = width / 22
        password3.layer.borderColor = UIColor.blue.cgColor
        password3.layer.borderWidth = 2
        
        subView.addSubview(password4)
        password4.snp.makeConstraints { make in
            make.top.equalTo(password2.snp.top)
            make.left.equalTo(password3.snp.right).offset(20)
            make.width.height.equalTo(width / 11)
        }
        password4.layer.cornerRadius = width / 22
        password4.layer.borderColor = UIColor.blue.cgColor
        password4.layer.borderWidth = 2
        
        
        subView.addSubview(btn2)
        btn2.snp.makeConstraints { make in
            make.top.equalTo(password2.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(width / 4.65)
        }
        btn2.setTitle("2", for: .normal)
        btn2.layer.cornerRadius = width / 9.3
        btn2.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        btn2.backgroundColor = .blue
        
        subView.addSubview(btn1)
        btn1.snp.makeConstraints { make in
            make.top.equalTo(btn2.snp.top)
            make.right.equalTo(btn2.snp.left).offset(-30)
            make.width.height.equalTo(width / 4.65)
        }
        btn1.setTitle("1", for: .normal)
        btn1.layer.cornerRadius = width / 9.3
        btn1.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        btn1.backgroundColor = .blue
        
        subView.addSubview(btn3)
        btn3.snp.makeConstraints { make in
            make.top.equalTo(btn2.snp.top)
            make.left.equalTo(btn2.snp.right).offset(30)
            make.width.height.equalTo(width / 4.65)
        }
        btn3.setTitle("3", for: .normal)
        btn3.layer.cornerRadius = width / 9.3
        btn3.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        btn3.backgroundColor = .blue
        
        subView.addSubview(btn5)
        btn5.snp.makeConstraints { make in
            make.top.equalTo(btn2.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(width / 4.65)
        }
        btn5.setTitle("5", for: .normal)
        btn5.layer.cornerRadius = width / 9.3
        btn5.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        btn5.backgroundColor = .blue
        
        subView.addSubview(btn4)
        btn4.snp.makeConstraints { make in
            make.top.equalTo(btn5.snp.top)
            make.right.equalTo(btn5.snp.left).offset(-30)
            make.width.height.equalTo(width / 4.65)
        }
        btn4.setTitle("4", for: .normal)
        btn4.layer.cornerRadius = width / 9.3
        btn4.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        btn4.backgroundColor = .blue
        
        subView.addSubview(btn6)
        btn6.snp.makeConstraints { make in
            make.top.equalTo(btn5.snp.top)
            make.left.equalTo(btn5.snp.right).offset(30)
            make.width.height.equalTo(width / 4.65)
        }
        btn6.setTitle("6", for: .normal)
        btn6.layer.cornerRadius = width / 9.3
        btn6.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        btn6.backgroundColor = .blue
    
        subView.addSubview(btn8)
        btn8.snp.makeConstraints { make in
            make.top.equalTo(btn5.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(width / 4.65)
        }
        btn8.setTitle("8", for: .normal)
        btn8.layer.cornerRadius = width / 9.3
        btn8.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        btn8.backgroundColor = .blue
        
        subView.addSubview(btn7)
        btn7.snp.makeConstraints { make in
            make.top.equalTo(btn8.snp.top)
            make.right.equalTo(btn8.snp.left).offset(-30)
            make.width.height.equalTo(width / 4.65)
        }
        btn7.setTitle("7", for: .normal)
        btn7.layer.cornerRadius = width / 9.3
        btn7.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        btn7.backgroundColor = .blue
        
        subView.addSubview(btn9)
        btn9.snp.makeConstraints { make in
            make.top.equalTo(btn8.snp.top)
            make.left.equalTo(btn8.snp.right).offset(30)
            make.width.height.equalTo(width / 4.65)
        }
        btn9.setTitle("9", for: .normal)
        btn9.layer.cornerRadius = width / 9.3
        btn9.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        btn9.backgroundColor = .blue
        
        
        subView.addSubview(btn0)
        btn0.snp.makeConstraints { make in
            make.top.equalTo(btn8.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(width / 4.65)
        }
        btn0.setTitle("0", for: .normal)
        btn0.layer.cornerRadius = width / 9.3
        btn0.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        btn0.backgroundColor = .blue
        
        subView.addSubview(btnClear)
        btnClear.snp.makeConstraints { make in
            make.top.equalTo(btn0.snp.top)
            make.left.equalTo(btn0.snp.right).offset(30)
            make.width.height.equalTo(width / 4.65)
        }
        btnClear.setTitle("Clear", for: .normal)
        btnClear.layer.borderColor = UIColor.blue.cgColor
        btnClear.layer.borderWidth = 1
        btnClear.layer.cornerRadius = width / 9.3
        btnClear.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        btnClear.setTitleColor(.blue, for: .normal)
    }
    
    @objc func backTapped(){
        dismiss(animated: true)
    }
    
    
    @objc func btnTapped(_ button: UIButton){
        animatePress(button)
        if(button == btnClear){
            if counter > 0 {
                changeColor(number: counter, isRemoved: true)
                counter -= 1
                password.removeLast()
            }
        } else {
            if counter < 4 {
                password += button.titleLabel?.text ?? ""
                counter += 1
                changeColor(number: counter, isRemoved: false)
                if(counter == 4){
                    checkPassword()
                }
            }
        }
    }
    
    func animatePress(_ button: UIButton){
        button.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            button.alpha = 1
        }
    }
    
    func changeColor(number: Int, isRemoved: Bool){
        switch number{
        case 1:
            UIView.animate(withDuration: 0.15){ [weak self] in
                self?.password1.backgroundColor = (isRemoved ? .none : .blue)
            }
        case 2:
            UIView.animate(withDuration: 0.15){ [weak self] in
                self?.password2.backgroundColor = (isRemoved ? .none : .blue)
            }
        case 3:
            UIView.animate(withDuration: 0.15){ [weak self] in
                self?.password3.backgroundColor = (isRemoved ? .none : .blue)
            }
        case 4:
            UIView.animate(withDuration: 0.15){ [weak self] in
                self?.password4.backgroundColor = (isRemoved ? .none : .blue)
            }
        default:
            break
        }
    }
    
    func checkPassword(){
        
//        if FirebaseManager.validateUser(email: <#T##String#>, password: <#T##String#>)
        
        if(password == "1111"){
            
        } else {
            password1.backgroundColor = .red
            password1.layer.borderColor = UIColor.red.cgColor
            password2.backgroundColor = .red
            password2.layer.borderColor = UIColor.red.cgColor
            password3.backgroundColor = .red
            password3.layer.borderColor = UIColor.red.cgColor
            password4.backgroundColor = .red
            password4.layer.borderColor = UIColor.red.cgColor
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){ [weak self] in
                self?.password1.backgroundColor = .none
                self?.password1.layer.borderColor = UIColor.blue.cgColor
                self?.password2.backgroundColor = .none
                self?.password2.layer.borderColor = UIColor.blue.cgColor
                self?.password3.backgroundColor = .none
                self?.password3.layer.borderColor = UIColor.blue.cgColor
                self?.password4.backgroundColor = .none
                self?.password4.layer.borderColor = UIColor.blue.cgColor
            }
            counter = 0
            password = ""
            vibrate()
        }
    }
    
    
    
}





// width =  375.0 SE
// width =  428.0 13 Pro max
