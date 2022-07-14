//
//  LoginViewController.swift
//  BankTest
//
//  Created by Carlos Pacheco on 08/07/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    var loginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeElements()
        initializeViewModels()
    }
    
    func initializeElements() {
        usernameText.layer.borderColor = UIColor.red.cgColor
        passwordText.layer.borderColor = UIColor.red.cgColor
    }
    
    func initializeViewModels() {
        self.initializeCustomerViewModel()
    }
    
    func initializeCustomerViewModel() {
        loginViewModel.custormer.bind { [weak self] _ in
            guard let self = self else { return }
            
            if let customer = self.loginViewModel.custormer.value {
                print(customer.id)
                self.navigationController?.pushViewController(PaymentsViewController(customer: customer), animated: true)
            }
        }
    }

    @IBAction func loginButton(_ sender: Any) {
        var fail = false

        usernameText.layer.borderWidth = 0
        passwordText.layer.borderWidth = 0

        if let username = usernameText.text,
           let password = passwordText.text {

//            if username.isEmpty || password.isEmpty {
//                return
//            }

            if !username.isValidUsername() {
                usernameText.layer.borderWidth = 1

                fail = true
            }

            if !password.isValidPassword() {
                passwordText.layer.borderWidth = 1

                fail = true
            }

            if fail {
                return
            }

            loginViewModel.authenticate(username: username, password: password)
        }
    }
}
