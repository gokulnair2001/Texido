//
//  MainViewController.swift
//  Texido
//
//  Created by Gokul Nair on 31/08/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var replyTextField: UITextField!
    
    let haptic = haptickFeedback()
    
    var Messages:[String] = ["What can i help you with?"]
    var identity:[String] = ["Texido"]
    var chatBubble:[UIColor] = [.gray]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//MARK:- TableView methods

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = Messages[indexPath.row]
        cell.backgroundColor = chatBubble[indexPath.row]
        cell.layer.cornerRadius = 10
        cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.detailTextLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.layer.borderWidth = 2
        cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.detailTextLabel?.text = identity[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK:- User Reply/Questioning Methods

extension MainViewController: UITextFieldDelegate{
    
    
    @IBAction func askButton(_ sender: Any) {
        
        if replyTextField.text != ""{
            self.Messages.append(replyTextField.text!)
            self.identity.append("Me")
            self.chatBubble.append(.yellow)
            tableView.reloadData()
            haptic.haptiFeedback1()
            replyByTexido()
        }else{
            print("empty text field")
        }
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text != "" {
            return true
        }else{
            textField.placeholder = "Type Something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if replyTextField.text != ""{
            self.Messages.append(replyTextField.text!)
            tableView.reloadData()
            replyByTexido()
        }else{
            print("empty text field")
        }
        
    }
    
}

//MARK:- Texido Reply method

extension MainViewController{
    func replyByTexido(){
        
        switch (replyTextField.text)?.lowercased() {
        case "hi":
            Messages.append("Hi Gokul")
            utilities()
            break
        case "hello":
            Messages.append("Hello, My Name is Texido, a Text Assistant.How may I help you?")
            utilities()
            break
        case "how are you":
            Messages.append("I am fine, What about you?")
            utilities()
            break
        case "great":
            Messages.append("good")
            utilities()
            break
        case "good":
            Messages.append("great")
            utilities()
            break
        case "whats your name":
            Messages.append("Hi, My Name is Texido :)")
            utilities()
            break
        case "can you do a favour":
            Messages.append("Hi, My Name is Texido :)")
            utilities()
            break
        case "please call":
            Messages.append("Currently out of my abilities")
            utilities()
            break
        case "can we talk":
            Messages.append("Why not!")
            utilities()
            break
        case "what is your name?":
            Messages.append("Hi, My Name is Texido :)")
            utilities()
            break
        case "what is your name":
            Messages.append("Hi, My Name is Texido :)")
            utilities()
            break
        case "texido":
            Messages.append("Yes, Please..Its my name..can I help you..Just text me and i will get it done")
            utilities()
            break
        default:
            Messages.append("Command Not found")
            haptic.haptiFeedback1()
            utilities()
            break
        }
    }
}

//MARK:- Some required utilities

extension MainViewController{
    func utilities(){
        tableView.reloadData()
        identity.append("Texido")
        chatBubble.append(.gray)
        replyTextField.text?.removeAll()
    }
}
