//
//  ViewController.swift
//  hs-mobile-chat-app
//
//  Created by Matheus Ruschel on 5/20/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    @IBOutlet weak var googleButton: GIDSignInButton!
    @IBOutlet weak var fbButton: FBSDKLoginButton!
	
	let chatStoryboard = UIStoryboard(name: "Chat", bundle: nil)
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Do I need to repeat this? I've already put in app delegate
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        // Not this one though
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
        
        
        
            }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        
        
        if (error == nil) {
            print("Did sign In")
            let authentication = user.authentication
            let credential = FIRGoogleAuthProvider.credentialWithIDToken(authentication.idToken, accessToken: authentication.accessToken)
            FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                print("Hello \(user?.displayName)")
				
				let friendsViewController = self.chatStoryboard.instantiateViewControllerWithIdentifier("FriendsTableViewController") as! FriendsTableViewController

				self.showViewController(friendsViewController, sender: self)

				
            }
        } else {
            print("\(error.localizedDescription)")
        }
        
    }

    
    @IBAction func loginGoogle(sender: GIDSignInButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        // Add any custom logic here.
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String, annotation: AnyObject) -> Bool {
        var handled: Bool = FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
        // Add any custom logic here.
        return handled
    }
    
    override func viewDidAppear(animated: Bool) {

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

