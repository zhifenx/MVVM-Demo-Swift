//
//  RxSwiftLoginViewController.swift
//  MVVM-Demo-Swift
//
//  Created by zhifenx on 2021/5/11.
//

import UIKit

class RxSwiftLoginViewController: UIViewController {
    
    private var rootView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "RxSwift - Login"
        
        rootView = LoginView()
        rootView.backgroundColor = .white
        view.addSubview(rootView)
        rootView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
}
