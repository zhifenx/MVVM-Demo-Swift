//
//  LoginDataManager.swift
//  MVVM-Demo-Swift
//
//  Created by zhifenx on 2021/5/12.
//

import Foundation
import RxSwift

enum LoginError: Error {
    case error(_ decs: String)
}

/*
 *  简单模拟网络请求 添加2秒耗时
 */

class LoginDataManager {
    
    typealias Result = (_ msg: String) -> Void
    
    func requestLogin(param: String, result: @escaping Result) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            result(param)
        }
    }
    
    
    /// 模拟Rx网络请求
    /// - Parameter param: 这里作为mssage 使用onNext事件传出去
    /// - Returns: 返回一个Observable可监听者
    func rx_requestLogin(param: String) -> Observable<String> {
        return Observable.create { observer in
            
            let randomValue = Int.random(in: 0...10)
            
            if randomValue > 4 {//模拟成功事件
                observer.onNext("\(param) randomValue = \(randomValue)")
            }else {//模拟发生错误事件
                observer.onError(LoginError.error("rx_requestLogin error randomValue = \(randomValue)"))
            }
            
            //完成事件
            observer.onCompleted()
            
            return Disposables.create()
        }
        .delay(.seconds(2),
               scheduler: SerialDispatchQueueScheduler(qos: .default))//串行并发队列 内部使用DispatchQueue.global(qos: qos.qosClass)获取全局并发队列
        
    }
    
}
