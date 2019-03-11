//
//  ViewController.swift
//  Firebase-Chat
//
//  Created by Will Said on 11/6/18.
//  Copyright © 2018 Will Said. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // table view data source
    private var messages: [Message] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func send() {
        let text = textField.text ?? ""
        let time = Date().timeIntervalSince1970
        Message(text: text, time: time).send()
        
        textField.text = ""
        textField.resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .interactive
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        fetchMessages()
    }
    func fetchMessages() {
        Message.observe { message in
            DispatchQueue.main.async {
                self.messages.append(message)
                self.messages.sort(by: { (m1, m2) -> Bool in
                    return m1.time < m2.time
                })
                self.tableView.reloadData()
                let bottomIndexPath = IndexPath(row: self.messages.count - 1, section: 0)
                self.tableView.scrollToRow(at: bottomIndexPath, at: .bottom, animated: true)
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath)
        if let cell = cell as? MessageTableViewCell {
            let message = self.messages[indexPath.row]
            cell.dateLabel.text = message.time.formattedString()
            cell.messageTextLabel.text = message.text
        }
        return cell
    }
}

extension TimeInterval {
    func formattedString() -> String {
        let date = Date(timeIntervalSince1970: self)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium // Nov 6, 2018
        return formatter.string(from: date)
    }
}


