//
//  ShortcutsViewController.swift
//  Texido
//
//  Created by Gokul Nair on 01/09/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import UIKit
import MessageUI

class ShortcutsViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var phoneNoTextField: UITextField!
    @IBOutlet weak var mailContent: UITextView!
    @IBOutlet weak var mailAddress: UITextField!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var sendMessageView: UIView!
    @IBOutlet weak var messageContent: UITextView!
    @IBOutlet weak var mesgNumber: UITextField!
    
    let haptic = haptickFeedback()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callView.layer.cornerRadius = 10
        messageView.layer.cornerRadius = 10
        sendMessageView.layer.cornerRadius = 10
        
        callView.layer.borderColor = #colorLiteral(red: 0.8276559114, green: 0.3054199219, blue: 0.5941508412, alpha: 1)
        messageView.layer.borderColor = #colorLiteral(red: 1, green: 0.5054317117, blue: 0.5242763162, alpha: 1)
        sendMessageView.layer.borderColor = #colorLiteral(red: 0.1391454041, green: 0.7194875479, blue: 0.9509506822, alpha: 1)
        
        sendMessageView.layer.borderWidth = 2
        callView.layer.borderWidth = 2
        messageView.layer.borderWidth = 2
        
        
        backBtn.layer.cornerRadius = 10
        
        phoneNoTextField.attributedPlaceholder = NSAttributedString(string: "Enter Mobile Number",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        mailAddress.attributedPlaceholder = NSAttributedString(string: "Enter Mail ID",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        mesgNumber.attributedPlaceholder = NSAttributedString(string: "Enter Mobile Number",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer){
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        haptic.haptiFeedback1()
    }
    
}


//MARK:- Phone call shortcut methods

extension ShortcutsViewController{
    
    @IBAction func callBtn(_ sender: Any) {
        
        
        if phoneNoTextField.text?.count == 10 {
            
            let number = Int(phoneNoTextField.text!)
            if let phoneUrl = URL(string: "tel:\(number)"){
                if UIApplication.shared.canOpenURL(phoneUrl){
                    UIApplication.shared.open(phoneUrl, options: [:], completionHandler: nil)
                    haptic.haptiFeedback1()
                }else{
                    return
                }
            }
        }
            
        else{
            print("Not possible, number format wrong")
        }
        
    }
    
    
}


//MARK:- email shortcut method

extension ShortcutsViewController: MFMailComposeViewControllerDelegate{
    
    @IBAction func sendmailBtn(_ sender: Any) {
        
        sendMail()
        haptic.haptiFeedback1()
    }
    
    
    
    func sendMail() {
        guard MFMailComposeViewController.canSendMail() else {
            
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([mailAddress.text!])
        composer.setSubject(mailContent.text!)
        composer.setMessageBody("Hi Gokul, I want to report a problem in ePocket!", isHTML: false)
        
        present(composer, animated: true)
    }
    
}


//MARK:- message shortcut method

extension ShortcutsViewController{
    
    @IBAction func messageSendBtn(_ sender: Any) {
        sendMessage()
        haptic.haptiFeedback1()
    }
    
    func sendMessage(){
        
        if mesgNumber.text?.count == 10 {
        
        if(MFMessageComposeViewController.canSendText()) {
                   let controller = MFMessageComposeViewController()
            controller.body = messageContent.text!
            controller.recipients = [mesgNumber.text!]
            controller.messageComposeDelegate = self
        }else{
            print("number format is wrong")
            }
            
        }
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
       switch result {
       case .cancelled:
           print("cancelled")
       case .failed:
           print("failed")
       case .sent:
           print("sent")
       @unknown default:
           print("other error")
        }
    }
    
}
