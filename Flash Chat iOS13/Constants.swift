//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Srijan Bhatia on 31/10/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

struct Constants {
    static let appName = "⚡️FlashChat"
    static let cellIdentifier = "ReusableCell"
    static let receivedCellIdentifier = "ReceivedReusableCell"
    static let cellNibName = "MessageCell"
    static let receivedCellNibName = "ReceivedMessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}