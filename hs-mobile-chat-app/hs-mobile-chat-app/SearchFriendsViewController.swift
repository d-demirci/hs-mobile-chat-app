//
//  SearchFriendsViewController.swift
//  hs-mobile-chat-app
//
//  Created by Victor de Lima on 21/05/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import UIKit
import Firebase

class SearchFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var searchTextField: UITextField!

	var foundFriends = [User]()
	let ref = FIRDatabase.database().reference()
	private var refHandle: FIRDatabaseHandle!
    var labelNoData:UILabel? = nil

	let currentUser = FIRAuth.auth()?.currentUser!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ResultCell")
        configureTableViewContentMessage()
        updateLabelNoContent()
    }
    
    func configureTableViewContentMessage() {
    
        if foundFriends.count == 0 {

            labelNoData = UILabel(frame: CGRectMake(
                self.view.frame.width/2,
                self.view.frame.height/2,
                150,
                30
                ))
            labelNoData!.center = CGPointMake(self.view.frame.width/2,self.view.frame.height/2)
            labelNoData!.text = "Username list is empty."
            
        }
        
    }
    
    func updateLabelNoContent() {
        
        if foundFriends.count == 0 {
            self.view.addSubview(labelNoData!)
            
        } else {
            self.labelNoData?.removeFromSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)

	}
	
	override func viewWillDisappear(animated: Bool) {
		if refHandle != nil {
			ref.removeObserverWithHandle(refHandle)
		}
	}

	@IBAction func searchFriends(sender: UIButton) {
		foundFriends.removeAll()
		let username = searchTextField.text!
		
		if username != ""{

			findFriendsWithEmail(username)

		}
	}

	// MARK: - TableView Methods
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return foundFriends.count
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = self.tableView.dequeueReusableCellWithIdentifier("ResultCell", forIndexPath: indexPath)
		
		cell.textLabel?.text = foundFriends[indexPath.row].email

		
		return cell
	}
	

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
//		let data = []
//		
//		ref.child("friends").childByAutoId().setValue(data)
//
//		
//		let friendsVC = parentViewController?.childViewControllers.first as! FriendsTableViewController
//		friendsVC.friends.addObject(foundUsers[indexPath.row])

		
	}

    func findFriendsWithEmail(email:String) {
        foundFriends.removeAll()
        refHandle = ref.child("users").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
            
            if snapshot.value != nil {
                let userSnapshot: FIRDataSnapshot! = snapshot
                
                let userID = userSnapshot.key as String
                let friendEmail = userSnapshot.value!["email"] as! String
                
                if friendEmail == email {
                    self.foundFriends.append(User(email: email,userID: userID))
                    self.tableView.reloadData()
                }
                
            }
            self.updateLabelNoContent()
            
        })
        
    }


}
