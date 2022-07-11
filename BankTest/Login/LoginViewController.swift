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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        usernameText.layer.borderColor = UIColor.red.cgColor
        passwordText.layer.borderColor = UIColor.red.cgColor
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
            
            if !isValidUsername(username: username) {
                usernameText.layer.borderWidth = 1
                
                fail = true
            }
            
            if !isValidPassword(password: password) {
                passwordText.layer.borderWidth = 1
                
                fail = true
            }
            
            if fail {
                return
            }
            
            navigationController?.pushViewController(StatementsViewController(), animated: true)
        }
    }
    
    func isValidUsername(username: String) -> Bool {
        return username.isValidEmail() || username.isValidCPF()
    }
    
    func isValidPassword(password: String) -> Bool {
        return password.isValidPassword()
    }

}
