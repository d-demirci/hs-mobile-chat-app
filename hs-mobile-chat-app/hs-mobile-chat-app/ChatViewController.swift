//
//  ChatViewController.swift
//  hs-mobile-chat-app
//
//  Created by Victor de Lima on 21/05/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import UIKit
import JSQMessagesViewController

import Firebase

class ChatViewController: JSQMessagesViewController {

	var messages = [JSQMessage]()
	
	var outgoingBubbleImageView: JSQMessagesBubbleImage! // right side
	var incomingBubbleImageView: JSQMessagesBubbleImage! // left side
	let currentUser = FIRAuth.auth()?.currentUser
	
	// Firebase
	
	private var refHandle: FIRDatabaseHandle!

	var ref: FIRDatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
				
		senderId = currentUser!.email
		senderDisplayName = currentUser?.displayName
		
		title = "Chat with friend"
		
		setupBubbles()
		
		ref = FIRDatabase.database().reference()
		// removing collection view avatar size
		collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
		collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
		
    }

	func retriveOldMessages(){
		messages.removeAll()
		refHandle = ref.child("messages").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
			
			if snapshot.value != nil {
				
				let dict = snapshot.value as! [String:AnyObject]
				
				let dictMessage = dict["message"] as! [String:AnyObject]
				
				let text = dictMessage["text"] as! String
				let email = dictMessage["name"] as! String
				self.addMessage(id: email, text: text)
				self.finishReceivingMessage()
			}
		})

	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		retriveOldMessages()
	}
	
	
	// MARK: - JSQMessage

	override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
		return messages[indexPath.item]
	}
 
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return messages.count
	}

	override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
	
		
		var timestamp: NSTimeInterval {
			return NSDate().timeIntervalSince1970 * 1000
		}
		
		let email = (currentUser?.email!)! as String
		let data = ["message":["name":email,"text":text,"timestamp":timestamp]]
		ref.child("messages").childByAutoId().setValue(data)
		JSQSystemSoundPlayer.jsq_playMessageSentSound()
		
		// 5
		finishSendingMessage()
	}

	// MARK: - JSQMessage: JSQMessagesCollectionViewDataSource

	override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
		let message = messages[indexPath.row]
		if message.senderId == senderId {
			return outgoingBubbleImageView
		}else {
			return incomingBubbleImageView
		}
	}
	
	override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
		return nil
	}
	
	// MARK: - JSQMessage: Setup bubbles
	
	private func setupBubbles(){
		let factory = JSQMessagesBubbleImageFactory()
		outgoingBubbleImageView = factory.outgoingMessagesBubbleImageWithColor(UIColor.hsBlueColor())
		incomingBubbleImageView = factory.incomingMessagesBubbleImageWithColor(UIColor.hsGrayColor())
	}

	// MARK: - Collection View
	
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
		
		let message = messages[indexPath.item]
			
		if message.senderId == senderId {
			cell.textView!.textColor = UIColor.whiteColor()
		} else {
			cell.textView!.textColor = UIColor.blackColor()
		}
			
		return cell
	}

	// MARK: - Create Messages
	func addMessage(id id:String, text:String){
		let message = JSQMessage(senderId: id, displayName: "Friend", text: text)
		messages.append(message)
	}
	
	func sendMessage(data: [String: String]) {
		var mdata = data
		mdata["User"] = senderDisplayName
//		if let photoUrl = AppState.sharedInstance.photoUrl {
//			mdata[Constants.MessageFields.photoUrl] = photoUrl.absoluteString
//		}
		
		let ref = FIRDatabase.database().reference()
		// Push data to Firebase Database
		ref.child("messages").childByAutoId().setValue(mdata)
	}
	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//
//	}
}