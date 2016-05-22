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
    var email:String
}

class UserRegistrationManager {
    
   static let sharedInstance = UserRegistrationManager()
   let ref = FIRDatabase.database().reference()
   private var refHandle: FIRDatabaseHandle!
   var foundUsers:[User]? = [User]()
    
    func saveUserEmail(email:String)throws -> Bool {
        
        guard foundUsers != nil else {
            throw Error.ErrorUserListNil(msg:"User list can't be nil")
        }
        
        if !userEmailExists(email) {
            let data = ["email":email]
            ref.child("users").childByAutoId().setValue(data)
            return true
        }
        
        return false
    }
    
    func userEmailExists(email:String) ->Bool {
        
        for user in foundUsers! {
            if user.email == email {return true}
        }
        
        return false
    }
    
    func observeUsers() {
        refHandle = ref.child("users").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
        
            if snapshot.value != nil {
                let userSnapshot: FIRDataSnapshot! = snapshot
                let userInfo = userSnapshot.value as! Dictionary<String,String>
                self.foundUsers!.append(User(email: userInfo["email"]!))
            }
        
        })
        
    }
    
    
}
