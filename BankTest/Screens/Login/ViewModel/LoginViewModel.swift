//
//  LoginViewModel.swift
//  BankTest
//
//  Created by Carlos Pacheco on 12/07/22.
//

import Foundation
import Moya

class LoginViewModel {
    var customer: Observable<CustomerModel> = Observable(nil)
    var isBusy: Observable<Bool> = Observable(false)
    var isValidUsername: Observable<Bool> = Observable(true)
    var isValidPassword: Observable<Bool> = Observable(true)
    var errorMessage: Observable<String> = Observable("")
    
    let externalService = ExternalService()
    
    func authenticate(username: String, password: String) {
        self.isValidUsername.value = username.isValidUsername()
        self.isValidPassword.value = password.isValidPassword()
        
        if self.isValidUsername.value == false ||
            self.isValidPassword.value == false {
            return
        }
        
        self.isBusy.value = true
        
        externalService.login(username: username, password: password) { [weak self] customer in
            guard let self = self else { return }
            
            self.customer.value = customer
            self.isBusy.value = false
        } errorCB: { [weak self] message in
            guard let self = self else { return }
            
            self.errorMessage.value = message
            self.isBusy.value = false
        }
    }
}
