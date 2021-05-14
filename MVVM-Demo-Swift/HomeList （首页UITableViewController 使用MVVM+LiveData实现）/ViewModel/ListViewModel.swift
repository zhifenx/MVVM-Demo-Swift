//
//  ListViewModel.swift
//  MVVM-Demo-Swift
//
//  Created by zhifenx on 2021/5/10.
//

import Foundation

class ListViewModel {
    
    private var dataManager = ListViewDataManager()
    private var dataArr: [ListModel] = []
    var liveData: LiveData<[ListModel]> = LiveData([])

    init() {
        dataArr = initData()
        liveData.value = dataArr
    }
    
    
    /// 这里实际 开发中也可能是调用网络请求
    func initData() -> [ListModel] {
       return [
            ListModel(title: "LiveData - login demo", detail: "LiveData"),
            ListModel(title: "RxSwift - login demo", detail: "RxSwift"),
        ]
    }
    
    func insertData() {
//        let data = dataManager.fetchData()
        //... 转成 [ListModel]
        let model = ListModel(title: "新增 model - " + "\(dataArr.count + 1)", detail: "新增")
        dataArr.append(model)
        liveData.value = dataArr
    }
}
