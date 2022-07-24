//
//  StatementsViewController.swift
//  BankTest
//
//  Created by Carlos Pacheco on 08/07/22.
//

import UIKit

class PaymentsViewController: UIViewController {
    var paymentsViewModel: PaymentsViewModel
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var waitingIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var paymentsTableView: UITableView!
    
    init(_ viewModel: PaymentsViewModel) {
        paymentsViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCustomerData()
        initTableView()
        initNavigationBar()
        initViewModel()
    }
    
    func initNavigationBar() {
        setNavigationBar(imageNamed: "logout 2")
    }
    
    func initCustomerData() {
        nameLabel.text = paymentsViewModel.customer.customerName
        accountLabel.text = "\(paymentsViewModel.customer.accountNumber) / \(paymentsViewModel.customer.branchNumber)"
        balanceLabel.text = String(format: "R$ %.2f", Float(paymentsViewModel.customer.checkingAccountBalance)) // todo presenter should no be in view
    }
}

// MARK: ViewModel bind
extension PaymentsViewController {
    func initViewModel() {
        paymentsViewModel.payments.bind { [weak self] _ in
            guard let self = self else { return }
            
            self.paymentsTableView.reloadData()
        }
        
        paymentsViewModel.isBusy.bind { [weak self] _ in
            guard let self = self else { return }
            
            if let isBusy = self.paymentsViewModel.isBusy.value {
                self.waitingIndicatorView.isHidden = !isBusy
            }
        }
        
        paymentsViewModel.loadPayments(userId: self.paymentsViewModel.customer.id)
    }
}

// MARK: TableView DataSource
extension PaymentsViewController: UITableViewDataSource {
    func initTableView() {
        paymentsTableView.dataSource = self
        paymentsTableView.delegate = self
        paymentsTableView.register(PaymentCell.self)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Recentes" // TODO viewForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentsViewModel.payments.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(PaymentCell.self, for: indexPath)
        if let payment = paymentsViewModel.payments.value?[indexPath.row] {
            cell.dateLabel.text = payment.paymentDate
        }
        
        return cell
    }
}

// MARK: TableView Delegate
extension PaymentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
