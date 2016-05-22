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
    
    func saveUserEmail(email:String)throws -> Bool {
        
        guard foundUsers != nil else {
            throw Error.ErrorUserListNil(msg:"User lis can't be nil")
        }
        
        if !userEmailExists(email) {
            let data = ["email":email,"username":""]
            ref.child("users").childByAutoId().setValue(data)
            return true
        }
        
        return false
    }
    
    func saveUsername(username:String,forEmail email:String) {
        
        let userQuery = (ref.child("users").child(email))
        
        
    }
    

    func userEmailExists(email:String) ->Bool {
        
        for user in foundUsers! {
            if user.email == email {return true}
        }
        
        return false
    }
    
    func userUsernameExists(username:String) ->Bool {
        
        for user in foundUsers! {
            if user.username == username {return true}
        }
        
        return false
    }
    
    func observeUsers() {
        refHandle = ref.child("users").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
        
            if snapshot.value != nil {
                let userSnapshot: FIRDataSnapshot! = snapshot
                let userInfo = userSnapshot.value as! Dictionary<String,String>
                self.foundUsers!.append(User(username: userInfo["username"]!, email: userInfo["email"]!))
            }
        
        })
        
    }
    
    
}
