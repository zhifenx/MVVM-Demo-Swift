//
//  RxSwiftViewModel.swift
//  MVVM-Demo-Swift
//
//  Created by zhifenx on 2021/5/11.
//

import Foundation
import RxSwift

class RxSwiftViewModel {
//    var subject: PublishSubject<LoginModel>!
    var subject: BehaviorSubject<LoginModel>!
    
    private var model = LoginModel()
    
    init() {
        model.loginType = .none
//        subject = PublishSubject()
        subject = BehaviorSubject(value: LoginModel())
    }
    
    func refreshLoginType() {
        let type = LoginModel.LoginType(rawValue: Int.random(in: 0...7))!
        model.loginType = type
        updateData()
    }
    
    func textDidChange(_ enabled: Bool) {
        model.enabled = enabled
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
        subject.onNext(model)
    }
}
