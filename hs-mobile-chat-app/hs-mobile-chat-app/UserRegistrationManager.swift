//
//  UserRegistrationManager.swift
//  hs-mobile-chat-app
//
//  Created by Matheus Ruschel on 5/21/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import UIKit
import Firebase

struct User {
    var username:String
    var email:String
}

class UserRegistrationManager {
    
   static let sharedInstance = UserRegistrationManager()
   let ref = FIRDatabase.database().reference()
   private var refHandle: FIRDatabaseHandle!
    var foundUsers:[User]? = [User]()
    
    func saveUser(username:String,email:String) -> Bool {
        let data = ["username":username,"email":email]
        ref.child("user").childByAutoId().setValue(data)
        return true
    }
    
    func checkUsersForExistingUserEmail(email:String) ->Bool {
        
        for user in foundUsers! {
            if user.email == email {return false}
        }
        
        return true
    }
    
    func checkUsersForExistingUsername(username:String) ->Bool {
        
        for user in foundUsers! {
            if user.username == username {return false}
        }
        
        return true
    }
    
    func observeUsers() {
        refHandle = ref.child("users").observeEventType(.Value, withBlock: { (snapshot) -> Void in
        
            if snapshot.value != nil {
                let userSnapshot: FIRDataSnapshot! = snapshot
                let usersInfo = userSnapshot.value as! Dictionary<String, Dictionary<String,String>>
                let userInfo = usersInfo["user"]!
                self.foundUsers!.append(User(username: userInfo["username"]!, email: userInfo["email"]!))
            }
        
        })
        
    }
    
    
}
