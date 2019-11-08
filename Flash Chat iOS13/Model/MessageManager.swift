//
//  MessageManager.swift
//  Flash Chat iOS13
//
//  Created by Vinicius Santana on 20/06/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Firebase

struct MessageManager {
    let db : Firestore
    let collection : CollectionReference
    var delegate : MessageManagerDelegate?
    
    
    init() {
        db = Firestore.firestore()
        collection = db.collection(K.FStore.collectionName)
    }
    
    func sendMessage(_ message : Message) {
        collection.addDocument(data: [
            K.FStore.senderField : message.sender,
            K.FStore.bodyField: message.body,
            K.FStore.dateField: message.date.timeIntervalSince1970
        ]) { (error) in
            if let e = error {
                print("There was an issue saving data to firestore, \(e)")
            } else {
                print("Message successfuly sended")
            }
        }
    }
    
    func loadMessages() {
        
        collection
            .order(by: K.FStore.dateField)
            .addSnapshotListener() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var messages : [Message] = []
                    for document in querySnapshot!.documents {
                        messages.append(self.documentToMessage(document))
                    }
                    
                    self.delegate?.didReceiveMessages(self, messages: messages)
                }
        }
    }
    
    
    func documentToMessage(_ document : QueryDocumentSnapshot) -> Message{
        let data = document.data()
        
        let sender = data[K.FStore.senderField] as? String ?? ""
        let body = data[K.FStore.bodyField] as? String ?? ""
        let date = data[K.FStore.dateField] as? Date ?? Date()
        
        return Message(sender: sender, body: body, date: date)
    }
}

protocol MessageManagerDelegate {
    func didReceiveMessages(_ messageManager: MessageManager, messages : [Message])
}
