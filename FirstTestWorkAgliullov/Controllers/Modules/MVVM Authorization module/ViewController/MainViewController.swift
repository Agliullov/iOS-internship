//
//  MainViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 20.09.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit
import RxSwift

class MainViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = ViewControllerViewModel()
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    var loginNavigationController: LoginNavigationController?
    var loginController: LoginViewController?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.loginStatus
            .drive(onNext: { [unowned self] status in
                switch status {
                case .none:
                    self.showLogin()
                case .error(_):
                    self.showLogin()
                case .user(let user):
                    self.showAccess(user)
                }
            })
            .disposed(by: disposeBag)
        
        logoutButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel.logout()
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func showLogin() {
        infoView.isHidden = true
        infoLabel.text = ""
        guard loginNavigationController != nil else {
            loginNavigationController = UIStoryboard.loginNC
            loginController = loginNavigationController?.loginController
            
            present(loginNavigationController!, animated: true, completion: nil)
            return
        }
    }
    
    fileprivate func showAccess(_ username: String) {
        infoView.isHidden = false
        infoLabel.text = "Вы вошли как: \(username)"
        dismiss(animated: true) { [unowned self] in
            self.loginController = nil
            self.loginNavigationController = nil
        }
    }
}

private extension UIStoryboard {
    
    static var mainStoryboard: UIStoryboard? {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static var loginNC: LoginNavigationController? {
        return UIStoryboard.mainStoryboard?.instantiateViewController(withIdentifier: "LoginNC") as? LoginNavigationController
    }
}
