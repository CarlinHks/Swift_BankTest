//
//  PaymentsViewModel.swift
//  BankTest
//
//  Created by Carlos Pacheco on 14/07/22.
//

import Foundation

class PaymentsViewModel {
    var coordinator: Coordinator
    let externalService = ExternalService()
    
    var customer: CustomerModel
    
//    var customer: Observable<CustomerModel>
    var payments: Observable<[PaymentModel]> = Observable([])
    var isBusy: Observable<Bool> = Observable(true)
    var errorMessage: Observable<String> = Observable("")
    
    init(_ coordinator: Coordinator, _ customer: CustomerModel) {
        self.coordinator = coordinator
        self.customer = customer
    }
    
    func loadPayments(userId: String) {
        externalService.loadPayments(userId: userId) { [weak self] payments in
            guard let self = self else { return }
            
            self.payments.value = payments
            self.isBusy.value = false
        } errorCB: { [weak self] message in
            guard let self = self else { return }
            
            self.errorMessage.value = message
            self.isBusy.value = false
        }
    }
}

// MARK: Coordinating protocol
extension PaymentsViewModel: Coordinating {
}
