//
//  RxSwiftViewModel.swift
//  MVVM-Demo-Swift
//
//  Created by zhifenx on 2021/5/11.
//

import Foundation
import RxSwift

class RxSwiftViewModel {
//    var subject: PublishSubject<LoginModel> = PublishSubject()
    var subject: BehaviorSubject<LoginModel> = BehaviorSubject(value: LoginModel())
    
    private var model = LoginModel()
    
    func refreshLoginType() {
        let type = LoginModel.LoginType(rawValue: Int.random(in: 0...7))!
        model = model.setLoginType(type)
        updateData()
    }
    
    func textDidChange(_ enabled: Bool) {
        model.enabled = enabled
        updateData()
    }
    
    func login() {
        model.isLogin = !model.isLogin
        
        if model.isLogin {
            model.nickname = model.loginDecs() + "成功"
            model.decs = "退出登录"
        }else {
            model.nickname = "MVVM - \(model.loginDecs())"
            model.decs = model.loginDecs()
        }
        
        updateData()
    }
    
    func updateData() {
        subject.onNext(model)
    }
}
