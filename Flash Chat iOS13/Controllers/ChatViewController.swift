//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let authManage : AuthenticationManager = FirebaseAuthenticationManager()
    var messageManager = MessageManager()
    
    var messages : [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageManager.delegate = self
        
        configureUI()
        configureTableView()
        loadData()
    }
    
    func configureUI(){
        title =  K.appName
        navigationItem.hidesBackButton = true
    }
    
    func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }
    
    func loadData(){
        messageManager.loadMessages()
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let sender =  authManage.getLoggedUser() {
            let message = Message(sender: sender, body: messageBody, date: Date())
            messageManager.sendMessage(message)
            self.messageTextfield.text = ""
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        authManage.logOut()
        navigationController?.popToRootViewController(animated: true)
    }
    
}

//MARK: -  UITableViewDataSource
extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        if message.sender == authManage.getLoggedUser()! {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBuble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBuble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        return cell
    }
    
}

//MARK: -  UITableViewDelegate
extension ChatViewController : UITableViewDelegate {
    
}


//MARK: -  MessageManagerDelegate
extension ChatViewController : MessageManagerDelegate {
    func didReceiveMessages(_ messageManager: MessageManager, messages: [Message]) {
        self.messages = messages
        DispatchQueue.main.async {
            self.tableView.reloadData()
            let indexPath = IndexPath(row: messages.count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    
}
