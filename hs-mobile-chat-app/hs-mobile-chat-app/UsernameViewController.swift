//
//  UsernameViewController.swift
//  hs-mobile-chat-app
//
//  Created by Matheus Ruschel on 5/21/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import UIKit
import Firebase

class UsernameViewController: UIViewController {

    @IBOutlet weak var labelSelectUsername: UILabel!
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var buttonSelect: UIButton!

	let chatStoryboard = UIStoryboard(name: "Chat", bundle: nil)

	//	let userID = FIRAuth.auth()?.currentUser?.providerID
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

	
	func isUsernameExist(username username:String)->Bool{
		return false
	}
    
    func setUsername(username: String) {
        
        let user = FIRAuth.auth()!.currentUser!
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = username
        changeRequest.commitChangesWithCompletion(){ (error) in
            if let error = error {
                let alert = HSAlertMessageFactory.createMessage(.Error, msg: error.localizedDescription).onOk({_ in})
                self.presentViewController(alert, animated: true, completion: nil)
                return
            }
            let chatNavController = self.chatStoryboard.instantiateViewControllerWithIdentifier("NavigationChat")
            self.showViewController(chatNavController, sender: self)
        }
    }
	
	@IBAction func createUsername(sender: UIButton) {
		
		let username = textFieldUsername.text
		
		if username == "" {
			let alert = HSAlertMessageFactory.createMessage(.Alert, msg: "Please, put an username.").onOk({_ in})
			self.presentViewController(alert, animated: true, completion: nil)
		}
		
		if isUsernameExist(username: username!){
			let alert = HSAlertMessageFactory.createMessage(.Error, msg: "Username alredy exist. Please, try again.").onOk({_ in})
			self.presentViewController(alert, animated: true, completion: nil)
		}else{
			setUsername(username!)
        }
	
	}
	
	
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
