//
//  LDLoginViewModel.swift
//  MVVM-Demo-Swift
//
//  Created by zhifenx on 2021/5/11.
//

import Foundation

class LDLoginViewModel {
    var loginData: LiveData<LoginModel>!
    
    private var model = LoginModel()
    private var passwordTextValid = false
    private var phoneNumberTextValid = false
    
    init() {
        model.loginType = .none
        loginData = LiveData(model)
    }
    
    func refreshLoginType() {
        let type = LoginModel.LoginType(rawValue: Int.random(in: 0...7))!
        model.loginType = type
        updateData()
    }
    
    func passwrodTextDidChange(_ text: String) {
        passwordTextValid = text.count >= 4
        updateNextButtonEnabled()
    }
    
    func phoneNumberTextDidChange(_ text: String) {
        phoneNumberTextValid = text.count > 3
        updateNextButtonEnabled()
    }
    
    func updateNextButtonEnabled() {
        model.enabled = passwordTextValid && phoneNumberTextValid
        updateData()
    }
    
    func login() {
        model.isLogin = !model.isLogin
        
        if model.isLogin {
            model.nickname = model.decs + "成功"
        }else {
            model.nickname = "MVVM - \(model.decs)"
        }
        
        updateData()
    }
    
    func updateData() {
        loginData.value = model
    }
}
