//
//  MainCoordinator.swift
//  BankTest
//
//  Created by Carlos Pacheco on 22/07/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func eventOccurred(with type: Event) {
        switch type {
        case .loginButtonTapped(let customer):
            var viewControllr: UIViewController & Coordinating = PaymentsViewController(customer: customer)
            viewControllr.coordinator = self
            navigationController?.pushViewController(viewControllr, animated: true)
        }
    }
    
    func start() {
        var loginViewControllr: UIViewController & Coordinating = LoginViewController()
        loginViewControllr.coordinator = self
        
        navigationController?.setViewControllers([loginViewControllr], animated: false)
    }
}
