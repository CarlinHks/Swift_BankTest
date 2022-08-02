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
    var viewModel: LoginViewModel!
    
    var coordinator: CoordinatorSpy!
    var externalService: ExternalServiceSpy!
    
    override func setUp() {
        super.setUp()
        
        externalService = ExternalServiceSpy()
        coordinator = CoordinatorSpy()
        viewModel = LoginViewModel(coordinator: coordinator, externalService: externalService)
    }
    
    // MARK: CoordinatorSpy
    class CoordinatorSpy: Coordinator {
        var navigationController = UINavigationController()
        var event: Event = Event.none
        
        func eventOccurred(with type: Event) {
            event = type
        }
        
        func start() {
            // Do nothing
        }
    }
    
    // MARK: ExternalServiceSpy
    class ExternalServiceSpy: ExternalService {
        var didLogin = false
        
        var returnSuccess = false
        
        override func login(username: String,
                            password: String,
                            completion: @escaping (Result<CustomerModel, NetworkErrors>) -> Void) {
            didLogin = true
            
            if returnSuccess {
                let customer = CustomerModel(id: "id", customerName: "customerName", accountNumber: "accountNumber", branchNumber: "branchNumber", checkingAccountBalance: 0)
                completion(.success(customer))
            } else {
                completion(.failure(.decodeError))
            }
        }
    }
    
    // MARK: Tests
    func testAuthenticateSuccess() {
        externalService.returnSuccess = true
        
        viewModel.authenticate(username: "carlos@pacheco.com", password: "Q1!")
        
        XCTAssertEqual(viewModel.isValidUsername.value, true)
        XCTAssertEqual(viewModel.isValidPassword.value, true)
        XCTAssertEqual(viewModel.isBusy.value, false)
        
        XCTAssertEqual(externalService.didLogin, true)
        
        switch coordinator.event {
        case .loginButtonTapped(customer: _):
            break
        default:
            XCTFail("Invalid event")
        }
//        XCTAssertEqual(coordinator.event, .loginButtonTapped(customer: _))
    }
    
    func testAuthenticateFailDecode() {
        viewModel.authenticate(username: "carlos@pacheco.com", password: "Q1!")
        
        XCTAssertEqual(viewModel.isValidUsername.value, true)
        XCTAssertEqual(viewModel.isValidPassword.value, true)
        XCTAssertEqual(viewModel.isBusy.value, false)
        
        XCTAssertEqual(externalService.didLogin, true)
        
        switch coordinator.event {
        case .none:
            break
        default:
            XCTFail("Invalid event")
        }
    }
    
    func testAuthenticateFail_invalidUsername() {
        viewModel.authenticate(username: "carlos@.", password: "Q1!")
        
        XCTAssertEqual(viewModel.isValidUsername.value, false)
        XCTAssertEqual(viewModel.isValidPassword.value, true)
        XCTAssertEqual(viewModel.isBusy.value, false)
        
        XCTAssertEqual(externalService.didLogin, false)
    }
    
    func testAuthenticateFail_invalidPassword() {
        viewModel.authenticate(username: "carlos@pacheco.com", password: "Q11")
        
        XCTAssertEqual(viewModel.isValidUsername.value, true)
        XCTAssertEqual(viewModel.isValidPassword.value, false)
        XCTAssertEqual(viewModel.isBusy.value, false)
        
        XCTAssertEqual(externalService.didLogin, false)
    }
}
