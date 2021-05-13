//
//  LiveData.swift
//  MVVM-Demo-Swift
//
//  Created by zhifenx on 2021/5/10.
//

import Foundation

class LiveData<T> {
    typealias Observer = (T) -> Void
    var observer: Observer?

    var value: T {
        didSet {
            observer?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func observe(observer: Observer?) {
        self.observer = observer
        observer?(value)
    }
}
