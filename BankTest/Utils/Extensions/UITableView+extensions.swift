//
//  UiTableView+extensions.swift
//  BankTest
//
//  Created by Carlos Pacheco on 23/07/22.
//

import Foundation
import UIKit

extension UITableView {
    func register<T>(_ type: T.Type) {
        let className = String(describing: type)
        self.register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UITableViewCell> (_ type: T.Type, for indexPath: IndexPath) -> T {
        let className = String(describing: type)
        if let cell: T = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T {
            return cell
        }
        return T()
    }
}
