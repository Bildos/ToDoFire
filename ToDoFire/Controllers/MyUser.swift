//
//  User.swift
//  ToDoFire
//
//  Created by Андрей on 9/12/19.
//  Copyright © 2019 Andry Borisov. All rights reserved.
//

import Foundation
import Firebase

struct MyUser {
    
    let uid: String
    let email: String!
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
}
