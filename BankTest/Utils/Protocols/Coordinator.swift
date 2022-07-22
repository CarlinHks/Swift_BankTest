//
//  Coordinator.swift
//  BankTest
//
//  Created by Carlos Pacheco on 22/07/22.
//

import Foundation
import UIKit

enum Event {
    case loginButtonTapped(customer: CustomerModel)
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    
    func eventOccurred(with type: Event)
    func start()
}
