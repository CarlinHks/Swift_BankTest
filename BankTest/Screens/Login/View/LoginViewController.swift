//
//  LoginViewController.swift
//  BankTest
//
//  Created by Carlos Pacheco on 08/07/22.
//

import UIKit

class LoginViewController: UIViewController {
    var loginViewModel = LoginViewModel()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initElements()
        initCustomerViewModel()
    }
    
    private func initElements() {
        usernameTextField.layer.borderColor = UIColor.red.cgColor
        passwordTextField.layer.borderColor = UIColor.red.cgColor
    }
    
    private func initCustomerViewModel() {
        loginViewModel.custormer.bind {[weak self] _ in
            guard let self = self else { return }
            
            if let customer = self.loginViewModel.custormer.value {
                self.coordinator?.eventOccurred(with: .loginButtonTapped(customer: customer))
            }
        }
        
        loginViewModel.isBusy.bind {[weak self] _ in
            guard let self = self else { return }
            
            if let isBusy = self.loginViewModel.isBusy.value {
                self.loginButton.isEnabled = !isBusy
            }
        }
    }
    
    private func dismissViewError() {
        usernameTextField.layer.borderWidth = 0
        passwordTextField.layer.borderWidth = 0
    }
    
    @IBAction private func loginButton(_ sender: Any) {
        var fail = false
        
        dismissViewError()
        
        if let username = usernameTextField.text,
           let password = passwordTextField.text {
            
            if !username.isValidUsername() {
                usernameTextField.layer.borderWidth = 1
                
                fail = true
            }
            
            if !password.isValidPassword() {
                passwordTextField.layer.borderWidth = 1
                
                fail = true
            }
            
            if fail {
                return
            }
            
            loginViewModel.authenticate(username: username, password: password)
        }
    }
}

// MARK: Coordinating protocol
extension LoginViewController: Coordinating {
}
