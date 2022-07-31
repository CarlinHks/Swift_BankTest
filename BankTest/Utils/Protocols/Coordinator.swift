//
//  Coordinator.swift
//  BankTest
//
//  Created by Carlos Pacheco on 22/07/22.
//

import Foundation
import UIKit

enum Event {
    case none
    case loginButtonTapped(customer: CustomerModel)
}

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func eventOccurred(with type: Event)
    func start()
}
