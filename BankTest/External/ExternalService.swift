//
//  External.swift
//  BankTest
//
//  Created by Carlos Pacheco on 20/07/22.
//

import Foundation
import Moya

enum NetworkErrors: Error {
    case noDataError
    case decodeError
    case internalServerError(Error)
    
    func getErrorMessage() -> String {
        switch self {
        case .noDataError:
            return "Not Found!"
        case .decodeError:
            return "Decode Fail!"
        case .internalServerError(let error):
            return error.localizedDescription
        }
    }
}

class ExternalService {
    let provider = MoyaProvider<MoyaService>()
    
    func login(username: String,
               password: String,
               completion: @escaping (Result<CustomerModel, NetworkErrors>) -> Void) {
        provider.request(.login(username: username, password: password)) { result in
            switch result {
            case let .success(response):
                let decoder = JSONDecoder()
                let data = response.data
                
                do {
                    let custormers = try decoder.decode([CustomerModel].self, from: data)
                    
                    if let customer = custormers.first {
                        completion(.success(customer))
                    } else {
                        completion(.failure(.noDataError))
                    }
                } catch {
                    completion(.failure(.decodeError))
                }
                
            case let .failure(error):
                completion(.failure(.internalServerError(error)))
            }
        }
    }
    
    func loadPayments(userId: String,
                      completion: @escaping (Result<[PaymentModel], NetworkErrors>) -> Void) {
        provider.request(.payments(id: userId)) { result in
            switch result {
            case let .success(response):
                let decoder = JSONDecoder()
                let data = response.data
                
                do {
                    let payments = try decoder.decode([PaymentModel].self, from: data)
                    completion(.success(payments))
                } catch {
                    completion(.failure(.decodeError))
                }
                
            case let .failure(error):
                completion(.failure(.internalServerError(error)))
            }
        }
        return
    }
}
