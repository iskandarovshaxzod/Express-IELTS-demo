//
//  BaseViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 23.11.2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    let width      = UIScreen.main.bounds.width
    let height     = UIScreen.main.bounds.height
    let btmPadding = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    let topPadding = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    
    let loadingView = UIView()
    let spinnerView = UIView()
    let spinner     = UIActivityIndicatorView()
    
    var keyboardHeight = 0.0
    var iskeyboardActive = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        initViews()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        switch traitCollection.userInterfaceStyle{
            case .light, .unspecified:
                Database.shared.userMode = .light
            case .dark:
                Database.shared.userMode = .dark
            default: break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        iskeyboardActive = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        iskeyboardActive = false
    }
    
    //MARK: Methods for initialization
    
    func configureNavBar(){}
    func initViews(){}
    func setUpViews(){}
    
    //MARK: Methods
    
    func vibrate(){
        UIDevice.vibrate()
    }
    
    func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        HapticsManager.vibrate(for: type)
    }

    func showLoading(){
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loadingView.backgroundColor = .gray.withAlphaComponent(0.6)
        loadingView.isUserInteractionEnabled = true
        loadingView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                action: #selector(loadingViewTapped)))
        
        loadingView.addSubview(spinnerView)
        spinnerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
        spinnerView.backgroundColor = "cl_cell_back".color
        spinnerView.layer.cornerRadius = 15
        
        spinnerView.addSubview(spinner)
        spinner.style = .large
        spinner.hidesWhenStopped = true
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        spinner.startAnimating()
    }
    
    func hideLoading(){
        spinner.stopAnimating()
        loadingView.removeFromSuperview()
    }
    
    @objc func loadingViewTapped() {
        hideLoading()
    }
    
    //MARK: Methods for showing ALERTS
    
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
    
    func showActionAlert(title: String, message: String, actions: [String], handler: @escaping (UIAlertAction) -> ()) {
        let c = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { str in
            c.addAction(UIAlertAction(title: str, style: .default, handler: handler))
        }
        c.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(c, animated: true)
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
