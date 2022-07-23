//
//  PaymentsViewModel.swift
//  BankTest
//
//  Created by Carlos Pacheco on 14/07/22.
//

import Foundation

class PaymentsViewModel {
    let externalService = ExternalService()
    
//    var customer: Observable<CustomerModel>
    var payments: Observable<[PaymentModel]> = Observable([])
    var isBusy: Observable<Bool> = Observable(true)
    var errorMessage: Observable<String> = Observable("")
    
//    init(customer: CustomerModel) {
//
//    }
    
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
