//
//  MainCoordinator.swift
//  BankTest
//
//  Created by Carlos Pacheco on 22/07/22.
//

import Foundation
import UIKit

class MainCoordinator {
    var navigationController: UINavigationController
    let externalService: ExternalService
    
    init(navigationController: UINavigationController, externalService: ExternalService) {
        self.navigationController = navigationController
        self.externalService = externalService
    }
    
    func start() {
        let viewModel = LoginViewModel(coordinator: self, externalService: externalService)
        let viewControllr = LoginViewController(viewModel)
        
        navigationController.setViewControllers([viewControllr], animated: false)
    }
    
    func eventOccurred(with type: Event) {
        switch type {
        case .none: break
        case .loginButtonTapped(let customer):
            let viewModel = PaymentsViewModel(coordinator: self, customer: customer, externalService: externalService)
            let viewController = PaymentsViewController(viewModel)

            navigationController.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: Coordinator
extension MainCoordinator: Coordinator {
    
}
