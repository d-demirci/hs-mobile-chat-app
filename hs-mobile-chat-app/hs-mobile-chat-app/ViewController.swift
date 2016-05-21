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

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    @IBOutlet weak var signInButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
        
            }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        
        
        if (error == nil) {
            print("Did Sign In")
            
        } else {
            print("\(error.localizedDescription)")
        }
        
    }

    
    @IBAction func loginGoogle(sender: GIDSignInButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    override func viewDidAppear(animated: Bool) {

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

