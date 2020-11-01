//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    var messages: [Message] = []
    let db = Firestore.firestore()
    
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.appName
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.register(UINib(nibName: Constants.receivedCellNibName, bundle: nil), forCellReuseIdentifier: Constants.receivedCellIdentifier)
        loadMessages()
    }
    
    func loadMessages() {
        
        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            if let e = error {
                print(e)
            }
            else
            {
                if let snapshotDocuments = querySnapshot?.documents {
                    self.messages = []
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let sender = data[Constants.FStore.senderField] as? String, let body = data[Constants.FStore.bodyField] as? String, let date = data[Constants.FStore.dateField] as? TimeInterval {
                            let messageData = Message(sender:sender, body: body, date: date)
                            self.messages.append(messageData)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(Constants.FStore.collectionName).addDocument(data:[Constants.FStore.senderField: messageSender, Constants.FStore.bodyField: messageBody, Constants.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                if let e = error {
                    print(e)
                }
                else {
                    print("no error")
                }
            }
        } else {
          print("error")
        }
        messageTextfield.text = ""
    }
    
    @IBAction func logOutClicked(_ sender: UIBarButtonItem) {
    let firebaseAuth = Auth.auth()
    do {
        try firebaseAuth.signOut()
        navigationController?.popToRootViewController(animated: true)
        
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
      
    }
    
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let user = Auth.auth().currentUser?.email {
            if user == messages[indexPath.row].sender{
                let tableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for:indexPath) as! MessageCell
                tableViewCell.messageLabel.text = messages[indexPath.row].body
                return tableViewCell
            }
            else
            {
                let tableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.receivedCellIdentifier, for:indexPath) as! ReceivedMessageCell
                tableViewCell.messageLabel.text = messages[indexPath.row].body
                return tableViewCell
            }
        }
        return UITableViewCell()
    }
}
