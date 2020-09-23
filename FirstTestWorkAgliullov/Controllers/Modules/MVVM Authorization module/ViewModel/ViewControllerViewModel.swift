//
//  ViewControllerViewModel.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 20.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import RxSwift
import RxCocoa

struct ViewControllerViewModel {
    
    let loginStatus = AuthorizationManager.sharedManager.status.asDriver().asDriver(onErrorJustReturn: .none)
    
    func logout() {
        AuthorizationManager.sharedManager.logout()
    }
}
