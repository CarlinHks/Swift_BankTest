//
//  LoginViewModel.swift
//  BankTest
//
//  Created by Carlos Pacheco on 12/07/22.
//

import Foundation
import Moya

class LoginViewModel {

    // Separate Moya calls in other layer
    let provider = MoyaProvider<MoyaService>()
    var custormer: Observable<CustomerModel> = Observable(nil)
    var isBusy: Observable<Bool> = Observable(false)

    func authenticate(username: String, password: String) {
        
        self.isBusy.value = true
        
        provider.request(.login(username: username, password: password)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                let decoder = JSONDecoder()
                let data = response.data
//                let statusCode = response.statusCode
                
                do {
                    let custormers = try decoder.decode([CustomerModel].self, from: data)
                    self.custormer.value = custormers.first
                } catch {
                    // print alert in view
                    print(error)
                }
            
            case let .failure(error):
                print(error)
            }
            
            self.isBusy.value = false
        }
        return
    }
}
