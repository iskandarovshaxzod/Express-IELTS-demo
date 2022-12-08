//
//  BaseViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 23.11.2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    let width  = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    let btmPadding = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    let topPadding = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    
    var keyboardHeight = 0.0
    var iskeyboardActive = false

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        configureNavBar()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        iskeyboardActive = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        iskeyboardActive = false
    }
    
    
    func initViews(){}
    func setUpViews(){}
    func configureNavBar(){}
    
    func vibrate(){
        UIDevice.vibrate()
    }

    func showLoading(){}
    
    func hideLoading(){}
    
    func showMessage(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    func showSureInfo(title: String, message: String, handler: @escaping (UIAlertAction) -> ()){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: handler))
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        if iskeyboardActive{
            openKeyboard()
        }
    }
    
    @objc func keyboardWillHide(){
        closeKeyboard()
    }
    
    func openKeyboard(){
        
    }
    
    func closeKeyboard(){
        
    }
}
