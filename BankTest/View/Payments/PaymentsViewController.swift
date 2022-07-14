//
//  StatementsViewController.swift
//  BankTest
//
//  Created by Carlos Pacheco on 08/07/22.
//

import UIKit

class PaymentsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contaLabel: UILabel!
    @IBOutlet weak var saldoLabel: UILabel!
    
    var customer: Customer
    
    init( customer: Customer ) {
        self.customer = customer
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        updateCustomerData()
    }
    
    func setNavigationBar() {
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        // your custom view for back image with custom size
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 27, height: 27))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 27, height: 27))
        
        if let imgBackArrow = UIImage(named: "logout 2") {
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
    
    func updateCustomerData() {
        nameLabel.text = customer.customerName
        contaLabel.text = "\(customer.accountNumber) / \(customer.branchNumber)"
        saldoLabel.text = String(format: "R$ %.2f", Float(customer.checkingAccountBalance))
    }
}
