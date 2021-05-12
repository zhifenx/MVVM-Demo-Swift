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
    private var dataManager = LoginDataManager()
    private var disposeBag = DisposeBag()
    
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
        
        dataManager.rx_requestLogin(param: model.decs)
            .observe(on: MainScheduler.instance)//切换到主线程
            .subscribe { [weak self] result in
            
                print("rx_requestLogin - ", self?.model.buttonTitle ?? "", result)
                
            self?.model.isLogin = !(self?.model.isLogin ?? false)
            self?.updateData()
            
        } onError: { [weak self] error in
            print(self?.model.buttonTitle ?? "", (error as! LoginError))
            self?.updateData()
        } onCompleted: {
            print("rx_requestLogin - onCompleted")
        } onDisposed: {
            print("rx_requestLogin - disposed")
        }
        .disposed(by: disposeBag)

    }
    
    func updateData() {
        subject.onNext(model)
    }
}
