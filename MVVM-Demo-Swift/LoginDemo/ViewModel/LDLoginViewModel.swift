//
//  LDLoginViewModel.swift
//  MVVM-Demo-Swift
//
//  Created by zhifenx on 2021/5/11.
//

import Foundation

class LDLoginViewModel {
    private var model = LoginModel()
    private var oldText: String?
    
    var loginData: LiveData<LoginModel>!
    
    init() {
        loginData = LiveData(model)
    }
    
    func refreshLoginType() {
        let type = LoginModel.LoginType(rawValue: Int.random(in: 0...7))!
        loginData.value = model.setLoginType(type)
    }
    
    func textDidChange(text: String) {
        if text != oldText {
            model.enabled = text.count >= 6
            oldText = text
            updateData()
        }
    }
    
    func login() {
        model.isLogin = !model.isLogin
        
        if model.isLogin {
            model.nickname = model.loginDecs() + "成功"
            model.decs = "退出登录"
        }else {
            model.nickname = "zhifenx - \(model.loginDecs())"
            model.decs = model.loginDecs()
        }
        
        updateData()
    }
    
    func updateData() {
        loginData.value = model
    }
}
