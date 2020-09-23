//
//  LoginViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 20.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    @IBOutlet weak var vkButton: UIButton!
    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var passVisibleButton: UIButton!
    @IBOutlet weak var rePassButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        let viewModel = LoginViewModel(usernameText: usernameTextField.rx.text.orEmpty.asDriver(),
                                       passwordText: passwordTextField.rx.text.orEmpty.asDriver())
        
        viewModel.credentialsValid
            .drive(onNext: { [unowned self] valid in
                self.enterButton.isEnabled = valid
            })
            .disposed(by: disposeBag)
        
        enterButton.rx.tap
            .withLatestFrom(viewModel.credentialsValid)
            .filter { $0 }
            .flatMapLatest { [unowned self] valid -> Observable<AuthenticationStatus> in
                viewModel.login(self.usernameTextField.text!, password: self.passwordTextField.text!)
                    .trackActivity(viewModel.activityIndicator)
                    .observeOn(SerialDispatchQueueScheduler(qos: .userInteractive))
        }
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [unowned self] autenticationStatus in
            switch autenticationStatus {
            case .none:
                break
            case .user(_):
                break
            case .error(let error):
                self.showError(error)
            }
            AuthorizationManager.sharedManager.status.accept(autenticationStatus)
        })
            .disposed(by: disposeBag)
        
        viewModel.activityIndicator
            .distinctUntilChanged()
            .drive(onNext: { [unowned self] active in
                self.hideKeyboard()
                self.activityIndicator.isHidden = !active
                self.enterButton.isEnabled = !active
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func hideKeyboard() {
        self.usernameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    fileprivate func showError(_ error: AuthenticationError) {
        let title: String
        let message: String
        
        switch error {
        case .server, .badResponse:
            title = "Произошла ошибка"
            message = "Ошибка на сервере"
        case .badCredentials:
            title = "Неверные учетные данные"
            message = "Данного пользователя не существует"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === usernameTextField {
            passwordTextField.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return false
    }
}
