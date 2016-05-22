//
//  FriendsTableViewController.swift
//  hs-mobile-chat-app
//
//  Created by Victor de Lima on 21/05/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {

	var friends : NSMutableArray!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem()
		friends = NSMutableArray()
		friends.addObject("General chat")
		
		navigationItem.title = "HootChat"
		let nibCell = UINib(nibName: "FriendTableViewCell", bundle: nil)
		tableView.registerNib(nibCell, forCellReuseIdentifier: "FriendCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		// retrive friends from firebase
		self.tableView.reloadData()
	}

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell:FriendTableViewCell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath) as! FriendTableViewCell

		cell.nameLabel.text = friends[indexPath.row] as? String
		
        return cell
    }
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let chatStoryboard = UIStoryboard(name: "Chat", bundle: nil)
		let chatViewController = chatStoryboard.instantiateViewControllerWithIdentifier("ChatViewController") as! ChatViewController
		
		self.showViewController(chatViewController, sender: self)
	}


}
