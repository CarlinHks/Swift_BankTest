//
//  PaymentCell.swift
//  BankTest
//
//  Created by Carlos Pacheco on 14/07/22.
//

import UIKit

class PaymentCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        initCellView()
    }
    
    private func initCellView() {
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = UIColor.lightGray.cgColor
        
//        cellView.layer.shadowColor = UIColor.red.cgColor
//        cellView.layer.shadowOpacity = 0.5
//        cellView.layer.shadowOffset = .zero
//        cellView.layer.shadowRadius = 20
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
