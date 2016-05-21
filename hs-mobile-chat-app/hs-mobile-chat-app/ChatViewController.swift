//
//  ChatViewController.swift
//  hs-mobile-chat-app
//
//  Created by Victor de Lima on 21/05/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController
class ChatViewController: JSQMessagesViewController {

	var messages = [JSQMessage]()
	
	var outgoingBubbleImageView: JSQMessagesBubbleImage! // right side
	var incomingBubbleImageView: JSQMessagesBubbleImage! // left side
	let currentUser = FIRAuth.auth()?.currentUser
	
    override func viewDidLoad() {
        super.viewDidLoad()
				
		senderId = currentUser!.providerID
		senderDisplayName = currentUser?.displayName
		
		title = "Chat with friend"
		
		setupBubbles()
		
		// removing collection view avatar size
		collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
		collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		// messages from someone else
		addMessage(id:"foo", text: "Hey person!")
		// messages sent from local sender
		addMessage(id:senderId, text: "Yo!")
		addMessage(id:senderId, text: "I like turtles!")
		// animates the receiving of a new message on the view
		finishReceivingMessage()
	}
    
	// MARK: - JSQMessage

	override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
		return messages[indexPath.item]
	}
 
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return messages.count
	}

	override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
	
		addMessage(id: senderId, text: text)
		
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
		outgoingBubbleImageView = factory.outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
		incomingBubbleImageView = factory.incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleGreenColor())
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
	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//
//	}
}