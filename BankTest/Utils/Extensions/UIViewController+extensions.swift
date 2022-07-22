//
//  Alert.swift
//  BankTest
//
//  Created by Carlos Pacheco on 21/07/22.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setNavigationBar(imageNamed: String) {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        // your custom view for back image with custom size
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 27, height: 27))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 27, height: 27))
        
        if let imgBackArrow = UIImage(named: imageNamed) {
            imageView.image = imgBackArrow
        }
        view.addSubview(imageView)
        
        let backTap = UITapGestureRecognizer(target: self, action: #selector(backToMain))
        view.addGestureRecognizer(backTap)
        
        let rightBarButtonItem = UIBarButtonItem(customView: view )
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func backToMain() {
        self.navigationController?.popViewController(animated: true)
    }
}
