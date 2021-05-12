//
//  RxSwiftLoginViewController.swift
//  MVVM-Demo-Swift
//
//  Created by zhifenx on 2021/5/11.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class RxSwiftLoginViewController: UIViewController {
    
    private lazy var rootView: LoginView = {
        var view = LoginView()
        view.backgroundColor = .white
        return view
    }()
    
    private var viewModel = RxSwiftViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "RxSwift - Login"
        
        setupSubviews()
        dataBinding()
    }
    
    deinit {
        print("RxSwiftLoginViewController deinit")
    }
    
    //MARK: - UI
    
    private func setupSubviews() {
        view.addSubview(rootView)
        rootView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        //RxCocoa 提供的tap control event 代替Target-Action
        rootView.nextButton.rx.tap.subscribe { [weak self] event in
            SVProgressHUD.show()
            self?.viewModel.updateLoginStatus()
        }
        .disposed(by: disposeBag)
        
        rootView.loginTypeButton.rx.tap.subscribe { [weak self] event in
            self?.viewModel.refreshLoginType()
        }
        .disposed(by: disposeBag)
        
        let phoneNumberValid = rootView.phoneNumberTextField.rx.text.orEmpty.map {
            $0.count >= 4
        }
        
        let passwordValid = rootView.passwordTextField.rx.text.orEmpty.map {
            $0.count >= 3
        }
        
        let everythingValid = Observable.combineLatest(passwordValid, phoneNumberValid) {
            $0 && $1
        }
        
        everythingValid.bind(to: rootView.nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        //这里为了更新model.enabled
        everythingValid.subscribe { [weak self] eventData in
            guard let enabled = eventData.element else {return}
            self?.viewModel.textDidChange(enabled)
        }
        .disposed(by: disposeBag)
    }
    
    //MARK: - 数据绑定
    
    private func dataBinding() {
        viewModel.subject.subscribe { [weak self] eventData in
            guard let model = eventData.element else {
                return
            }
            SVProgressHUD.dismiss()
            self?.rootView.nicknameLabel.text = model.nickname
            self?.rootView.nextButton.setTitle(model.buttonTitle, for: .normal)
            self?.rootView.nextButton.backgroundColor = model.enabled ? .hex(model.colorHexInt) : .gray
            self?.rootView.nicknameLabel.textColor = .hex(model.colorHexInt)
        }
        .disposed(by: disposeBag)
    }
}
