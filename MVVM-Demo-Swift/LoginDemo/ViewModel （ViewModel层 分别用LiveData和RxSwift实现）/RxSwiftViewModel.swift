//
//  RxSwiftViewModel.swift
//  MVVM-Demo-Swift
//
//  Created by zhifenx on 2021/5/11.
//

import Foundation
import RxSwift

class RxSwiftViewModel {

    //Subject 供View层 订阅
    var subject: BehaviorSubject<LoginModel>!
    
    private var model = LoginModel()
    
    /// 用于网络请求
    private var dataManager = LoginDataManager()
    
    /// 管理rx 订阅的生命周期
    private var disposeBag = DisposeBag()
    
    init() {
        model.loginType = .phone
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
            
            guard let err = error as? LoginError else {return}
            
            switch err {
            case .error(let decs):
                print(self?.model.buttonTitle ?? "", decs)
                self?.model.nickname = decs
            }

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
