//
//  PaymentsViewModel.swift
//  BankTest
//
//  Created by Carlos Pacheco on 14/07/22.
//

import Foundation
import Moya

class PaymentsViewModel {
    let provider = MoyaProvider<NetworkServices>()
    var payments: Observable<[Payment]> = Observable([])

    func loadPayments(userId: String) {
        provider.request(.payments(id: userId)) { result in
            switch result {
            case let .success(response):
                let decoder = JSONDecoder()
                let data = response.data
//                let statusCode = response.statusCode
                
                do {
                    let payments = try decoder.decode([Payment].self, from: data)
                    print(payments)
                } catch {
                    print(error)
                }
            
            case let .failure(error):
                print(error)
            }
        }
        return
    }
}
