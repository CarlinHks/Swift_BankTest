//
//  External.swift
//  BankTest
//
//  Created by Carlos Pacheco on 20/07/22.
//

import Foundation
import Moya

class ExternalService {
    let provider = MoyaProvider<MoyaService>()

    func login(username: String,
               password: String,
               successCB: @escaping (CustomerModel) -> Void,
               errorCB: @escaping (String) -> Void) {
        provider.request(.login(username: username, password: password)) { result in
            switch result {
            case let .success(response):
                let decoder = JSONDecoder()
                let data = response.data

                do {
                    let custormers = try decoder.decode([CustomerModel].self, from: data)
                    
                    if let customer = custormers.first {
                        return successCB(customer)
                    }
                    
                    return errorCB("Empty")
                } catch {
                    return errorCB(error.localizedDescription)
                }

            case let .failure(error):
                return errorCB(error.localizedDescription)
            }
        }
    }
}
