//
//  LoginModel.swift
//  BankTest
//
//  Created by Carlos Pacheco on 12/07/22.
//

// import Foundation

struct Customer {
    var id: String
    var customerName: String
    var accountNumber: String
    var branchNumber: String
    var checkingAccountBalance: Int
}

extension Customer: Decodable {
    
}
