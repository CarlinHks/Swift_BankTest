//
//  LoginViewModel.swift
//  BankTest
//
//  Created by Carlos Pacheco on 12/07/22.
//

import Foundation
import Moya

class LoginViewModel {

    let provider = MoyaProvider<NetworkServices>()
    var custormer: Observable<Customer> = Observable(nil)

    func authenticate(username: String, password: String) {
        provider.request(.login(username: username, password: password)) { result in
            switch result {
            case let .success(response):
                let decoder = JSONDecoder()
                let data = response.data
//                let statusCode = response.statusCode
                
                do {
                    let custormers = try decoder.decode([Customer].self, from: data)
                    self.custormer.value = custormers.first
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
