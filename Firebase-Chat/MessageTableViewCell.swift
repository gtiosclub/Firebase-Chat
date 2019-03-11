//
//  MessageTableViewCell.swift
//  Firebase-Chat
//
//  Created by Will Said on 11/6/18.
//  Copyright © 2018 Will Said. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageTextLabel: UILabel!
    
    @IBOutlet weak var dateLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
