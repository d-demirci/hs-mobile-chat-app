//
//  ChatViewController.swift
//  hs-mobile-chat-app
//
//  Created by Victor de Lima on 21/05/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import UIKit
import JSQMessagesViewController
class ChatViewController: JSQMessagesViewController {

	var messages = [JSQMessage]()
	
	var outgoingBubbleImageView: JSQMessagesBubbleImage! // right side
	var incomingBubbleImageView: JSQMessagesBubbleImage! // left side
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
		let mainVC = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
		senderId = mainVC.userID
		senderDisplayName = ""
		
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
    
	// MARK: - JSQMessage

	override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
		return messages[indexPath.item]
	}
 
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return messages.count
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
		outgoingBubbleImageView = factory.outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleGreenColor())
		incomingBubbleImageView = factory.incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
	}

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//
//	}
}