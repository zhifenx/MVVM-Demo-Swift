//
//  LoginModel.swift
//  MVVM-Demo-Swift
//
//  Created by zhifenx on 2021/5/11.
//

import Foundation

class LoginModel {
    
    enum LoginType: Int {
        case weChat = 0, phone, qq, code, apple, oneKey
    }
    
    var decs = ""
    var buttonTitle = ""
    var nickname = ""
    var enabled: Bool = false
    var colorHexInt: UInt = 0x00
    
    var isLogin: Bool {
        willSet {
            if newValue {
                nickname = decs + "成功"
                buttonTitle = "退出登录"
            }else {
                nickname = "MVVM - \(decs)"
                buttonTitle = decs
            }
        }
    }
    
    var loginType: LoginType {
        willSet {
            switch newValue  {
            case .weChat:
                decs = "微信登录"
                colorHexInt = 0x8B4513
            case .phone:
                decs = "手机号登录"
                colorHexInt = 0x7B68EE
            case .qq:
                decs = "QQ登录"
                colorHexInt = 0x8FBC8F
            case .code:
                decs = "验证码登录"
                colorHexInt = 0x20B2AA
            case .apple:
                decs = "苹果账号登录"
                colorHexInt = 0xFFC0CB
            case .oneKey:
                decs = "一键登录"
                colorHexInt = 0x6495ED
            }
            
            nickname = "MVVM - \(decs)"
            buttonTitle = decs
            isLogin = false
        }
    }
    
    init() {
        loginType = .phone
        isLogin = false
    }
}
