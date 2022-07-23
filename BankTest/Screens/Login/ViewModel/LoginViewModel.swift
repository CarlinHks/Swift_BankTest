//
//  LoginViewModel.swift
//  BankTest
//
//  Created by Carlos Pacheco on 12/07/22.
//

import Foundation

class LoginViewModel {
    let externalService = ExternalService()
    
    var customer: Observable<CustomerModel> = Observable(nil)
    var isBusy: Observable<Bool> = Observable(false)
    var isValidUsername: Observable<Bool> = Observable(true)
    var isValidPassword: Observable<Bool> = Observable(true)
    var errorMessage: Observable<String> = Observable("")
    
    func authenticate(username: String, password: String) {
        self.isValidUsername.value = username.isValidUsername()
        self.isValidPassword.value = password.isValidPassword()
        
        if self.isValidUsername.value == false ||
            self.isValidPassword.value == false {
            return
        }
        
        self.isBusy.value = true
        
        externalService.login(username: username,
                              password: password) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let customer):
                self.customer.value = customer
                self.isBusy.value = false

            case .failure(let error):
                self.errorMessage.value = error.getErrorMessage()
                self.isBusy.value = false

            }
        }
    }
}
