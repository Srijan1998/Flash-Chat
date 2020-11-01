//
//  ReceivedMessage.swift
//  Flash Chat iOS13
//
//  Created by Srijan Bhatia on 01/11/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class ReceivedMessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height/5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
