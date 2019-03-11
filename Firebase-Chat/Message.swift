//
//  Message.swift
//  Firebase-Chat
//
//  Created by Will Said on 11/6/18.
//  Copyright © 2018 Will Said. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Message {
    let text: String
    let time: TimeInterval
}

extension Message {
    func send() {
        let root = Database.database().reference()
        let ref = root.child("messages").childByAutoId()
        
        let data: [String: Any] = [
            "text": self.text,
            "date": self.time
        ]
        
        ref.setValue(data)
    }
    
    static func observe(handler: @escaping (Message) -> ()) {
        let root = Database.database().reference()
        root.child("messages").observe(.childAdded) { snapshot in
            
            if let data = snapshot.value as? [String: Any],
                let text = data["text"] as? String,
                let time = data["date"] as? TimeInterval
            {
                let message = Message(text: text, time: time)
                handler(message)
            }
            
        }
    }
}
