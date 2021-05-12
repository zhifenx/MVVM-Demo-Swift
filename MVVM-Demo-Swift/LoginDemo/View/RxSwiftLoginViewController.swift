//
//  RxSwiftLoginViewController.swift
//  MVVM-Demo-Swift
//
//  Created by zhifenx on 2021/5/11.
//

import UIKit
import RxSwift
import RxCocoa

class RxSwiftLoginViewController: UIViewController {
    
    private var rootView: LoginView!
    private var viewModel = RxSwiftViewModel()
    private var disposeBag = DisposeBag()
    
    private var randomColor: UIColor {
        UIColor(red: CGFloat(Int.random(in: 0...255)) / 255.0, green: CGFloat(Int.random(in: 100...255)) / 255.0, blue: CGFloat(Int.random(in: 0...255)) / 255.0, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "RxSwift - Login"
        
        addSubviews()
        bind()
    }
    
    deinit {
        print("RxSwiftLoginViewController deinit")
    }
    
    //MARK: - UI
    
    private func addSubviews() {
        rootView = LoginView()
        rootView.backgroundColor = .white
        view.addSubview(rootView)
        rootView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        rootView.nextButton.rx.tap.subscribe { [weak self] event in
            self?.viewModel.login()
        }
        .disposed(by: disposeBag)
        
        rootView.loginTypeButton.rx.tap.subscribe { [weak self] event in
            self?.viewModel.refreshLoginType()
        }
        .disposed(by: disposeBag)
        
        let nextButtonValid = rootView.passwordTextField.rx.text.orEmpty.map {
            $0.count >= 6
        }
        
        nextButtonValid.bind(to: rootView.nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        //这里为了更新model.enabled
        nextButtonValid.subscribe { [weak self] eventData in
            guard let enabled = eventData.element else {return}
            self?.viewModel.textDidChange(enabled)
        }
        .disposed(by: disposeBag)
    }
    
    //MARK: - 数据绑定
    
    private func bind() {
        viewModel.subject.subscribe { [weak self] eventData in
            guard let model = eventData.element else {
                return
            }
            
            self?.rootView.nicknameLabel.text = model.nickname
            self?.rootView.nextButton.setTitle(model.decs, for: .normal)
            self?.rootView.nextButton.backgroundColor = model.enabled ? self?.randomColor : .gray
        }
        .disposed(by: disposeBag)
    }
}
