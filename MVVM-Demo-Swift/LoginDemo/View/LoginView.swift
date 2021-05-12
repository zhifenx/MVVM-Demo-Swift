//
//  LoginView.swift
//  MVVM-Demo-Swift
//
//  Created by zhifenx on 2021/5/11.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    var bagImageView: UIImageView!
    var alphaBagView: UIView!
    var nicknameLabel: UILabel!
    var phoneNumberLabel: UILabel!
    var phoneNumberTextField: UITextField!
    var passwordTextField: UITextField!
    var nextButton: UIButton!
    var loginTypeButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bagImageView = UIImageView(image: UIImage(named: "login_backImg"))
        addSubview(bagImageView)
        
        alphaBagView = UIView()
        alphaBagView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        addSubview(alphaBagView)
        
        nicknameLabel = UILabel()
        nicknameLabel.textColor = .white
        nicknameLabel.text = "nickname label"
        nicknameLabel.textAlignment = .center
        addSubview(nicknameLabel)
        
        phoneNumberLabel = UILabel()
        phoneNumberLabel.textColor = .white
        phoneNumberLabel.text = "phone number label"
        phoneNumberLabel.textAlignment = .center
        addSubview(phoneNumberLabel)
        
        phoneNumberTextField = UITextField()
        phoneNumberTextField.backgroundColor = UIColor(white: 0.7, alpha: 1)
        phoneNumberTextField.borderStyle = .line
        phoneNumberTextField.placeholder = "输入账号"
        phoneNumberTextField.textColor = .white
        addSubview(phoneNumberTextField)
        
        passwordTextField = UITextField()
        passwordTextField.backgroundColor = UIColor(white: 0.7, alpha: 1)
        passwordTextField.borderStyle = .line
        passwordTextField.placeholder = "输入大于6位的字符串"
        passwordTextField.textColor = .white
        addSubview(passwordTextField)
        
        nextButton = UIButton()
        nextButton.setTitle("下一步", for: .normal)
        nextButton.backgroundColor = .white
        nextButton.setTitleColor(.white, for: .normal)
        addSubview(nextButton)
        
        loginTypeButton = UIButton()
        loginTypeButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        loginTypeButton.setTitleColor(.white, for: .normal)
        loginTypeButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        loginTypeButton.setTitle("使用其他账号登录", for: .normal)
        addSubview(loginTypeButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bagImageView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        alphaBagView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            make.left.equalTo(nicknameLabel.snp.left)
            make.right.equalTo(nicknameLabel.snp.right)
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(50)
            make.left.equalTo(passwordTextField.snp.left)
            make.right.equalTo(passwordTextField.snp.right)
            make.height.equalTo(48)
        }
        
        loginTypeButton.snp.makeConstraints { make in
            make.top.equalTo(nextButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(30)
        }
    }
}
