//
//  LDLoginViewController.swift
//  MVVM-Demo-Swift
//
//  Created by zhifenx on 2021/5/11.
//

import UIKit
import SnapKit

class LDLoginViewController: UIViewController {
    
    private var rootView: LoginView!
    private var viewModel = LDLoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LiveData - Login"
        
        addSubviews()
        bind()
    }
    
    deinit {
        print("LDLoginViewController deinit")
    }
    
    //MARK: - UI
    
    private func addSubviews() {
        rootView = LoginView()
        rootView.backgroundColor = .white
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
    
    private func bind() {
        viewModel.loginData.observe { [weak self] model in
            self?.rootView.nicknameLabel.text = model.nickname
            self?.rootView.nextButton.setTitle(model.buttonTitle, for: .normal)
            self?.rootView.nextButton.isEnabled = model.enabled
            self?.rootView.nextButton.backgroundColor = model.enabled ? .hex(model.colorHexInt) : .gray
            self?.rootView.nicknameLabel.textColor = .hex(model.colorHexInt)
        }
    }
    
    //MARK: - Action
    
    @objc func nextButtonAction() {
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
