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
    private var randomColor: UIColor {
        UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 100...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 1)
    }
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChangeNotification(_:)), name: UITextField.textDidChangeNotification, object: rootView.passwordTextField)
    }
    
    //MARK: - 数据绑定
    
    private func bind() {
        viewModel.loginData.observe { [weak self] model in
            self?.rootView.nicknameLabel.text = model.nickname
            self?.rootView.phoneNumberLabel.text = model.phoneNumber
            self?.rootView.nextButton.setTitle(model.decs, for: .normal)
            self?.rootView.nextButton.isEnabled = model.enabled
            self?.rootView.nextButton.backgroundColor = model.enabled ? self?.randomColor : .gray
        }
    }
    
    //MARK: - Action
    
    @objc func nextButtonAction() {
        viewModel.login()
    }
    
    @objc func loginTypeButtonAction() {
        viewModel.refreshLoginType()
    }
    
    @objc func textDidChangeNotification(_ notification: NSNotification) {

        guard let textField = notification.object as? UITextField, let text = textField.text else {
            return
        }
        viewModel.textDidChange(text: text)
    }
    
}
