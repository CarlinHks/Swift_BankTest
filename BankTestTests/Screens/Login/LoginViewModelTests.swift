//
//  LoginViewModel.swift
//  BankTestTests
//
//  Created by Carlos Pacheco on 30/07/22.
//

// import Foundation

import XCTest
@testable import BankTest

class LoginViewModelTests: XCTestCase {
    var coordinator: CoordinatorSpy!
    var viewModel: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        
        coordinator = CoordinatorSpy()
        viewModel = LoginViewModel(coordinator)
    }
    
    // MARK: Spy
    class CoordinatorSpy: Coordinator {
        var navigationController: UINavigationController?
        
        var event: Event = Event.none
        
        func eventOccurred(with type: Event) {
            event = type
        }
        
        func start() {
            // Do nothing
        }
    }
    
    // MARK: Tests
    func testNavigateToPaymentsScreen_NoCustomer() {
        coordinator.event = .none
        
        viewModel.navigateToPaymentsScreen()
        
        switch coordinator.event {
        case .none:
            break
        default:
            XCTFail("Invalid event")
        }
        
//        XCTAssertEqual(coordinator.event, .none)
    }
}
