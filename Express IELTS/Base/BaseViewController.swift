//
//  BaseViewController.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 23.11.2022.
//

import UIKit
import Lottie

class BaseViewController: UIViewController {
    
    let width      = UIScreen.main.bounds.width
    let height     = UIScreen.main.bounds.height
    let btmPadding = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    let topPadding = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    
    let loadingView = UIView()
    let spinnerView = UIView()
    let spinner     = UIActivityIndicatorView()
    
    let animationView = UIView()
    let animation     = AnimationView()
    
    var keyboardHeight   = 0.0
    var iskeyboardActive = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        initViews()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardDidShowNotification, object: nil)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "back".localized, style: .plain,
                                                           target: nil, action: nil)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                switch traitCollection.userInterfaceStyle {
                    case .dark:  scene.blurEffect = UIBlurEffect(style: .dark)
                    case .light: scene.blurEffect = UIBlurEffect(style: .light)
                    default: break
                }
            }
//            print("system mode: ", traitCollection.userInterfaceStyle.rawValue)
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

}

//MARK: Methods
extension BaseViewController {
    
    func vibrate(){
        UIDevice.vibrate()
    }
    
    func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        HapticsManager.vibrate(for: type)
    }

    func showLoading(){
        window?.addSubview(loadingView)
        
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
        spinnerView.backgroundColor    = "cl_cell_back".color
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
    
    func showAnimation(animationName: String, animationMode: LottieLoopMode = .loop,
                       completion: ((Bool) -> Void)? = nil) {
        window?.addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        animationView.backgroundColor          = .gray.withAlphaComponent(0.6)
        animationView.isUserInteractionEnabled = true
        animationView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                  action: #selector(animationViewTapped)))
        animationView.addSubview(animation)
        animation.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(width / 2)
        }
        animation.animation   = .named(animationName)
        animation.contentMode = .scaleAspectFit
        animation.loopMode    = animationMode
        animation.backgroundColor    = "cl_cell_back".color
        animation.layer.cornerRadius = 15
        animation.play { completed in
            completion?(completed)
        }
    }
    
    func hideAnimation() {
        animation.stop()
        animationView.removeFromSuperview()
    }
    
    @objc func animationViewTapped() {
        hideAnimation()
    }
}

//MARK: Methods for showing ALERTS
extension BaseViewController {
    
    func showErrorMessage(title: String? = nil, message: String? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    func showSureInfo(title: String? = nil, message: String? = nil, handler: @escaping (UIAlertAction) -> ()){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "yes".localized, style: .destructive, handler: handler))
        alert.addAction(UIAlertAction(title: "no".localized, style: .cancel))
        present(alert, animated: true)
    }
    
    func showActionAlert(title: String?, message: String?, actions: [String],
                         handler: @escaping (UIAlertAction) -> ()) {
        let c = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { str in
            if str == "delete".localized {
                c.addAction(UIAlertAction(title: str, style: .destructive, handler: handler))
            } else {
                c.addAction(UIAlertAction(title: str, style: .default, handler: handler))
            }
        }
        c.addAction(UIAlertAction(title: "cancel".localized, style: .cancel))
        present(c, animated: true)
    }
}

// MARK: Methods for Observing Keyboard State
extension BaseViewController {
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
    
    func openKeyboard(){}
    
    func closeKeyboard(){}

    func resetMainViewController() {
        window?.rootViewController = UINavigationController(rootViewController: MainTabViewController())
    }
}
