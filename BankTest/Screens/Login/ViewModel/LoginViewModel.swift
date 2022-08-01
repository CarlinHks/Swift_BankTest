//
//  LoginViewModel.swift
//  BankTest
//
//  Created by Carlos Pacheco on 12/07/22.
//

import Foundation

class LoginViewModel {
    private let coordinator: Coordinator
    private let externalService: ExternalService
    
    var isBusy: Observable<Bool> = Observable(false)
    var isValidUsername: Observable<Bool> = Observable(true)
    var isValidPassword: Observable<Bool> = Observable(true)
    var errorMessage: Observable<String> = Observable("")
    
    init(coordinator: Coordinator, externalService: ExternalService) {
        self.coordinator = coordinator
        self.externalService = externalService
    }
    
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
                self.isBusy.value = false
                self.coordinator.eventOccurred(with: .loginButtonTapped(customer: customer))

            case .failure(let error):
                self.errorMessage.value = error.getErrorMessage()
                self.isBusy.value = false

            }
        }
    }
}
