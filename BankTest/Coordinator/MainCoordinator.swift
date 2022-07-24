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
    
    func start() {
        let viewModel = LoginViewModel(self)
        let viewControllr = LoginViewController(viewModel)
        
        navigationController?.setViewControllers([viewControllr], animated: false)
    }
    
    func eventOccurred(with type: Event) {
        switch type {
        case .loginButtonTapped(let customer):
            let viewModel = PaymentsViewModel(self, customer)
            let viewController = PaymentsViewController(viewModel)

            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
