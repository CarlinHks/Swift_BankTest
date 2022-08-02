//
//  PaymentsViewModelTests.swift
//  BankTestTests
//
//  Created by Carlos Pacheco on 01/08/22.
//

// import Foundation

import XCTest
@testable import BankTest

class PaymentsViewModelTests: XCTestCase {
    var coordinator: CoordinatorSpy!
    var externalService: ExternalServiceSpy!
    
    var viewModel: PaymentsViewModel!
    
    override func setUp() {
        super.setUp()
        
        let customer = CustomerModel(id: "id", customerName: "name", accountNumber: "number", branchNumber: "branch", checkingAccountBalance: 1)
        
        externalService = ExternalServiceSpy()
        coordinator = CoordinatorSpy()
        
        viewModel = PaymentsViewModel(coordinator: coordinator, customer: customer, externalService: externalService)
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
        var didPayments = false
        
        var returnSuccess = false
        
        override func loadPayments(userId: String,
                                   completion: @escaping (Result<[PaymentModel], NetworkErrors>) -> Void) {
            didPayments = true
            
            if returnSuccess {
                let payments = [PaymentModel(id: "id", paymentDate: "1/1/1", electricityBill: "name")]
                completion(.success(payments))
            } else {
                completion(.failure(.decodeError))
            }
        }
    }
    
    // MARK: Tests
    func testLoadPaymentsSuccess() {
        XCTAssertEqual(viewModel.payments.value?.count, 0)
        
        externalService.returnSuccess = true
        viewModel.loadPayments(userId: "1")
        
        XCTAssert(externalService.didPayments)
        XCTAssert(viewModel.payments.value!.count > 0)
    }
    
    func testLoadPaymentsFail_Decode() {
        XCTAssertEqual(viewModel.payments.value?.count, 0)
        XCTAssertEqual(viewModel.errorMessage.value, "")
        
        externalService.returnSuccess = false
        viewModel.loadPayments(userId: "1")
        
        XCTAssertNotEqual(viewModel.errorMessage.value, "")
        
        XCTAssert(externalService.didPayments)
        XCTAssertEqual(viewModel.payments.value?.count, 0)
    }
}
