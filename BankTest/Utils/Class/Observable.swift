//
//  Observable.swift
//  BankTest
//
//  Created by Carlos Pacheco on 13/07/22.
//

import Foundation

// Observable Template
class Observable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }

   init(_ value: T?) {
       self.value = value
   }

   private var listener: ((T?) -> Void)?

    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.listener = listener
        }
    }
}
