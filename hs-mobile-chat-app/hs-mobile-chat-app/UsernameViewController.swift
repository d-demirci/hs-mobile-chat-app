//
//  UsernameViewController.swift
//  hs-mobile-chat-app
//
//  Created by Matheus Ruschel on 5/21/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import UIKit

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
	
	@IBAction func createUsername(sender: UIButton) {
		
		let username = textFieldUsername.text
		
		if username == "" {
			// MSG: blank username
		}
		
		if isUsernameExist(username: username!){
			//Exist message
		}else{
			let chatNavController = chatStoryboard.instantiateViewControllerWithIdentifier("NavigationChat")
			self.showViewController(chatNavController, sender: self)
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
