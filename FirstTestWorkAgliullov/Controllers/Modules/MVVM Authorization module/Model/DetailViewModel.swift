//
//  LoginViewModel.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 22.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import Foundation

class LoginViewModel: LoginViewModelType {
    
    private var profile: AuthorizationModel
    
    init(profile: AuthorizationModel) {
        self.profile = profile
    }
    
    var description: String {
        return String(describing: "Email: \(profile.email) pass: \(profile.password)")
    }
}
