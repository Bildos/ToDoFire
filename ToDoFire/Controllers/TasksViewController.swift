//
//  TasksViewController.swift
//  ToDoFire
//
//  Created by Андрей on 9/3/19.
//  Copyright © 2019 Andry Borisov. All rights reserved.
//

import UIKit
import Firebase
class TasksViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    
  
    @IBOutlet var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = .clear
        cell.textLabel?.text = "This is cell number \(indexPath.row)"
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    @IBAction func addTask(_ sender: UIBarButtonItem) {
    }
    @IBAction func singOut(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
          dismiss(animated: true, completion: nil)
    }
}
