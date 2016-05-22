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

	var foundUsers:NSMutableArray!
	
	let ref = FIRDatabase.database().reference()
	private var _refHandle: FIRDatabaseHandle!

	let currentUser = FIRAuth.auth()?.currentUser!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		foundUsers = NSMutableArray()
		
		tableView.delegate = self
		tableView.dataSource = self
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ResultCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)

	}
	
	override func viewWillDisappear(animated: Bool) {
		if _refHandle != 0 {
			ref.removeObserverWithHandle(_refHandle)
		}
	}

	@IBAction func searchFriends(sender: UIButton) {
		foundUsers.removeAllObjects()
		let username = searchTextField.text!
		
		if username != ""{

			_refHandle = ref.child("friends").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
				
				if snapshot.value != nil {
					
					let myEmail = snapshot.value!["email"] as! String
					
					if myEmail != self.currentUser?.email {
						let friendUsername = snapshot.value!["friend"] as! String
						
						if friendUsername.containsString(username){
							self.foundUsers.addObject(friendUsername)
						}
						
						let indexPath = NSIndexPath(forRow: self.foundUsers.count-1, inSection: 0)
						
						self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
						
					}
					
				}
			})

		}
	}

	// MARK: - TableView Methods
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return foundUsers.count
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = self.tableView.dequeueReusableCellWithIdentifier("ResultCell", forIndexPath: indexPath)
		
		cell.textLabel?.text = foundUsers[indexPath.row] as! String

		
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

	/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
