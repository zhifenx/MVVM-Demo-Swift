//
//  LDLoginViewController.swift
//  MVVM-Demo-Swift
//
//  Created by zhifenx on 2021/5/11.
//

import UIKit
import SnapKit
import SVProgressHUD

class LDLoginViewController: UIViewController {
    
    private lazy var rootView: LoginView = {
        var view = LoginView()
        view.backgroundColor = .white
        return view
    }()
    
    private var viewModel = LDLoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LiveData - Login"
        
        setupSubviews()
        dataBinding()
    }
    
    deinit {
        print("LDLoginViewController deinit")
    }
    
    //MARK: - UI
    
    private func setupSubviews() {
        view.addSubview(rootView)
        rootView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        rootView.nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        rootView.loginTypeButton.addTarget(self, action: #selector(loginTypeButtonAction), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(phoneNumberTextDidChangeNotification(_:)), name: UITextField.textDidChangeNotification, object: rootView.phoneNumberTextField)
        
        NotificationCenter.default.addObserver(self, selector: #selector(passwordTextDidChangeNotification(_:)), name: UITextField.textDidChangeNotification, object: rootView.passwordTextField)
    }
    
    //MARK: - 数据绑定
    
    private func dataBinding() {
        viewModel.loginData.observe { [weak self] model in
            SVProgressHUD.dismiss()
            self?.rootView.nicknameLabel.text = model.nickname
            self?.rootView.nextButton.setTitle(model.buttonTitle, for: .normal)
            self?.rootView.nextButton.isEnabled = model.enabled
            self?.rootView.nextButton.backgroundColor = model.enabled ? .hex(model.colorHexInt) : .gray
            self?.rootView.nicknameLabel.textColor = .hex(model.colorHexInt)
        }
    }
    
    //MARK: - Action
    
    @objc func nextButtonAction() {
        SVProgressHUD.show()
        viewModel.updateLoginStatus()
    }
    
    @objc func loginTypeButtonAction() {
        viewModel.refreshLoginType()
    }
    
    @objc func passwordTextDidChangeNotification(_ notification: NSNotification) {

        guard let textField = notification.object as? UITextField, let text = textField.text else {
            return
        }
        viewModel.passwrodTextDidChange(text)
    }
    
    @objc func phoneNumberTextDidChangeNotification(_ notification: NSNotification) {

        guard let textField = notification.object as? UITextField, let text = textField.text else {
            return
        }
        viewModel.phoneNumberTextDidChange(text)
    }
    
}
