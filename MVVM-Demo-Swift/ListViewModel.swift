//
//  ListViewModel.swift
//  MVVM-Demo-Swift
//
//  Created by zhifenx on 2021/5/10.
//

import Foundation

class ListViewModel {
    
    private var dataArr: [ListModel] = []
    var liveData: LiveData<[ListModel]> = LiveData([])

    init() {
        dataArr = [
            ListModel(title: "mvvm list view - 1", detail: "m1"),
            ListModel(title: "mvvm list view - 2", detail: "m2"),
            ListModel(title: "mvvm list view - 3", detail: "m3"),
        ]
        
        liveData.value = dataArr
    }
    
    func insertData() {
        
    }
}
