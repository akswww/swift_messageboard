//
//  TableViewCell.swift
//  MessageBoard
//
//  Created by imac-1681 on 2023/7/10.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var nameCell: UILabel!
    @IBOutlet weak var textCell: UILabel!
    static let idfile = "TableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization cod
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
