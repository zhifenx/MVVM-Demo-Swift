//
//  LoginModel.swift
//  MVVM-Demo-Swift
//
//  Created by zhifenx on 2021/5/11.
//

import Foundation

class LoginModel {
    
    enum LoginType: Int {
        case none = 0, weChat, weiBo, phone, qq, code, apple, oneKey
    }
    
    var loginType: LoginType = .none
    var isLogin: Bool = false
    var decs: String = "登录"
    var nickname: String = ""
    var enabled: Bool = false
    
    init() {
        nickname = "MVVM - \(decs)"
    }
    
    func setLoginType(_ type: LoginType) -> LoginModel {
        loginType = type
        decs = loginDecs()
        nickname = "MVVM - \(decs)"
        isLogin = false
        
        return self
    }
    
    func loginDecs() -> String {
        switch loginType  {
        case .none:
            return "登录"
        case .weChat:
            return "微信登录"
        case .weiBo:
            return "微博登录"
        case .phone:
            return "手机号登录"
        case .qq:
            return "QQ登录"
        case .code:
            return "验证码登录"
        case .apple:
            return "苹果账号登录"
        case .oneKey:
            return "一键登录"
        }
    }
}
