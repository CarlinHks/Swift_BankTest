//
//  PaymentModel.swift
//  BankTest
//
//  Created by Carlos Pacheco on 14/07/22.
//

import Foundation

struct Payment {
    var id: String
    var paymentDate: String
    var electricityBill: String
}

// MARK: Decodable extension
extension Payment: Decodable {
    
}
