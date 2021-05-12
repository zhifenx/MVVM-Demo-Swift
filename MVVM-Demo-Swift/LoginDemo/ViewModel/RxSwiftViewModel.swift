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
        model.loginType = .phone
//        subject = PublishSubject()
        subject = BehaviorSubject(value: LoginModel())
    }
    
    func refreshLoginType() {
        let type = LoginModel.LoginType(rawValue: Int.random(in: 0...5))!
        model.loginType = type
        updateData()
    }
    
    func textDidChange(_ enabled: Bool) {
        model.enabled = enabled
        updateData()
    }
    
    func updateLoginStatus() {
        model.isLogin = !model.isLogin
        updateData()
    }
    
    func updateData() {
        subject.onNext(model)
    }
}
