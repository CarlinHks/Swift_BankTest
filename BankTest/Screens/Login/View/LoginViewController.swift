//
//  LoginViewController.swift
//  BankTest
//
//  Created by Carlos Pacheco on 08/07/22.
//

import UIKit

class LoginViewController: UIViewController {
    var loginViewModel: LoginViewModel
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var waitingIndicatorView: UIActivityIndicatorView!
    
    init(_ viewModel: LoginViewModel) {
        loginViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initElements()
        initViewModel()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        loginButtonTapped(loginButton!)
//    }
    
    private func initElements() {
        usernameTextField.layer.borderColor = UIColor.red.cgColor
        passwordTextField.layer.borderColor = UIColor.red.cgColor
    }
    
    @IBAction private func loginButtonTapped(_ sender: Any) {
        if let username = usernameTextField.text,
           let password = passwordTextField.text {
            loginViewModel.authenticate(username: username, password: password)
        }
    }
}

// MARK: ViewModel bind
// swiftlint: disable cyclomatic_complexity
extension LoginViewController {
    private func initViewModel() {
        loginViewModel.isBusy.bind {[weak self] _ in
            guard let self = self else { return }
            
            if let isBusy = self.loginViewModel.isBusy.value {
                self.loginButton.isEnabled = !isBusy
                self.waitingIndicatorView.isHidden = !isBusy
            }
        }
        
        loginViewModel.isValidUsername.bind {[weak self] _ in
            guard let self = self else { return }
            
            if let isValidUsername = self.loginViewModel.isValidUsername.value {
                if isValidUsername {
                    self.usernameTextField.layer.borderWidth = 0
                } else {
                    self.usernameTextField.layer.borderWidth = 1
                }
            }
        }
        
        loginViewModel.isValidPassword.bind {[weak self] _ in
            guard let self = self else { return }
            
            if let isValidPassword = self.loginViewModel.isValidPassword.value {
                if isValidPassword {
                    self.passwordTextField.layer.borderWidth = 0
                } else {
                    self.passwordTextField.layer.borderWidth = 1
                }
            }
        }
        
        loginViewModel.errorMessage.bind {[weak self] _ in
            guard let self = self else { return }
            
            if let errorMessage = self.loginViewModel.errorMessage.value {
                if errorMessage.count > 0 {
                    self.showAlert(message: errorMessage)
                }
            }
        }
    }
}
// swiftlint: enable cyclomatic_complexity
