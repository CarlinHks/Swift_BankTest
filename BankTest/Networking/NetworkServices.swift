//
//  NetworkServices.swift
//  BankTest
//
//  Created by Carlos Pacheco on 12/07/22.
//

import Foundation
import Moya

enum NetworkServices {
    case login(username: String, password: String)
    case payments(id: String)
}

// MARK: - TargetType Protocol Implementation
extension NetworkServices: TargetType {
    var baseURL: URL {
        URL(string: "https://60bd336db8ab3700175a03b3.mockapi.io/treinamento")!
    }

    var path: String {
        switch self {
        case .login(_, _):
            return "/Login"
        case .payments:
            return "/payments"
        }
    }

    var method: Moya.Method {
        switch self {
        case .login, .payments:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .login(let username, let password):
            return .requestParameters(parameters: ["username": username, "password": password], encoding: URLEncoding.queryString)
        case .payments(let id):
            return .requestParameters(parameters: ["userId": id], encoding: URLEncoding.queryString)
        }
    }

    var sampleData: Data {
        // TODO
        return Data()
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data { Data(self.utf8) }
}
