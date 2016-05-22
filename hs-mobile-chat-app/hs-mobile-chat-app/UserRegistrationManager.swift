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
	var userID:String
}

class UserRegistrationManager {
    
	static let sharedInstance = UserRegistrationManager()
	let ref = FIRDatabase.database().reference()
	private var refHandle: FIRDatabaseHandle!
	var foundUsers:[User]? = [User]()
	var currentUser = User(email: "", userID: "")
	
	func saveUserEmail(email:String)throws -> Bool {
        
        guard foundUsers != nil else {
            throw Error.ErrorUserListNil(msg:"User list can't be nil")
        }
		
		let (emailRegistered,id) = userEmailExists(email)
		
        if !emailRegistered {
			let data = ["email":email]
            ref.child("users").childByAutoId().setValue(data)
			currentUser.email = email
			setCurrentUserID()
			return true
        }
        currentUser.userID = id
        return false
    }
    
    func userEmailExists(email:String) ->(Bool,String) {
        
        for user in foundUsers! {
            if user.email == email {return (true,user.userID)}
        }
        
        return (false,"")
    }
    
    func observeUsers() {
        refHandle = ref.child("users").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
        
            if snapshot.value != nil {
                let userSnapshot: FIRDataSnapshot! = snapshot
				
				let userID = userSnapshot.key as String
				let email = userSnapshot.value!["email"] as! String

				self.foundUsers!.append(User(email: email,userID: userID))
            }
        })
    }
	
	func setCurrentUserID(){
		refHandle = ref.child("users").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
			
			if snapshot.value != nil {
				let userSnapshot: FIRDataSnapshot! = snapshot
				
				let userID = userSnapshot.key as String
				self.currentUser.userID = userID
			}
		})

	}
}
