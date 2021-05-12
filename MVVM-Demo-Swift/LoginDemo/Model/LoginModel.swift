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
    
    var isLogin: Bool = false
    var decs: String = "登录"
    var nickname: String = ""
    var enabled: Bool = false
    var colorHexInt: UInt = 0x00
    
    var loginType: LoginType {
        didSet {
            switch oldValue  {
            case .none:
                decs = "登录"
                colorHexInt = 0xFFA500
            case .weChat:
                decs = "微信登录"
                colorHexInt = 0x8B4513
            case .weiBo:
                decs = "微博登录"
                colorHexInt = 0xDAA520
            case .phone:
                decs = "手机登录"
                colorHexInt = 0x7CFC00
            case .qq:
                decs = "QQ登录"
                colorHexInt = 0x8FBC8F
            case .code:
                decs = "验证码登录"
                colorHexInt = 0x20B2AA
            case .apple:
                decs = "苹果账号登录"
                colorHexInt = 0x00BFFF
            case .oneKey:
                decs = "一键登录"
                colorHexInt = 0x6495ED
            }
            
            nickname = "MVVM - \(decs)"
            isLogin = false
        }
    }
    
    init() {
        loginType = .none
    }
}
