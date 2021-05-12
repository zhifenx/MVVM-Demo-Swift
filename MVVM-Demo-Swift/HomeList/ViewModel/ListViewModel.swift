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
        dataArr = [
            ListModel(title: "LiveData - login demo", detail: "LiveData"),
            ListModel(title: "RxSwift - login demo", detail: "RxSwift"),
        ]
        
        liveData.value = dataArr
    }
    
    func insertData() {
//        let data = dataManager.fetchData()
        //... 转成 [ListModel]
        let model = ListModel(title: "新增 model - " + "\(dataArr.count + 1)", detail: "新增")
        dataArr.append(model)
        liveData.value = dataArr
    }
}
