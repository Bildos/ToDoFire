//
//  ViewController.swift
//  ToDoFire
//
//  Created by Андрей on 9/3/19.
//  Copyright © 2019 Andry Borisov. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {

    @IBOutlet var notExist: UILabel!
    @IBOutlet var userPassword: UITextField!
    @IBOutlet var userEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        notExist.alpha = 0
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: "tasks", sender: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userPassword.text = ""
        userEmail.text = ""
    }
    
    @objc func kbDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + kbFrameSize.height)
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
        
    }
    
    @objc func kbDidHide() {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    
    func displayWarning(_ text: String){
        notExist.text = text
        
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {[weak self] in
            self?.notExist.alpha = 1
        }) { [weak self] completion in
            self?.notExist.alpha = 0
        }
    }
    
    
    @IBAction func login(_ sender: UIButton) {
        guard let email = userEmail.text, let password = userPassword.text, email != "", password != "" else {
            displayWarning("Info is incorrect")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            if error != nil {
                self?.displayWarning("Error occured")
                return
            }
            
            if user != nil {
                self?.performSegue(withIdentifier: "tasks", sender: nil)
                return
            }
            
            self?.displayWarning("No such User")
        }
        
    }
    
    @IBAction func register(_ sender: Any) {
        guard let email = userEmail.text, let password = userPassword.text, email != "", password != "" else {
            displayWarning("Info is incorrect")
            return
    }
        
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] (user, error) in
            if error == nil {
                if user != nil {
                    self?.performSegue(withIdentifier: "tasks", sender: nil)
                    
                }
                }
            }
        }
}

