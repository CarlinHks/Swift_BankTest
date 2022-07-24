//
//  PaymentsViewModel.swift
//  BankTest
//
//  Created by Carlos Pacheco on 14/07/22.
//

import Foundation

class PaymentsViewModel {
    private var coordinator: Coordinator
    private let externalService = ExternalService()
    
    var customer: CustomerModel
    
    var payments: Observable<[PaymentModel]> = Observable([])
    var isBusy: Observable<Bool> = Observable(true)
    var errorMessage: Observable<String> = Observable("")
    
    init(_ coordinator: Coordinator, _ customer: CustomerModel) {
        self.coordinator = coordinator
        self.customer = customer
    }
    
    func loadPayments(userId: String) {
        externalService.loadPayments(userId: userId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let payments):
                self.payments.value = payments
                self.isBusy.value = false
            case .failure(let error):
                self.errorMessage.value = error.getErrorMessage()
                self.isBusy.value = false
            }
        }
    }
}
