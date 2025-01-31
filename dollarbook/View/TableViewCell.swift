//
//  TableViewCell.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 18/10/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var timeLbl:UILabel!
    @IBOutlet weak var amountLbl:UILabel!
    @IBOutlet weak var iconImg:UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
