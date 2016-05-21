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

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    @IBOutlet weak var googleButton: GIDSignInButton!
    @IBOutlet weak var fbButton: FBSDKLoginButton!
		
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        fbButton.delegate = self
        fbButton.readPermissions = ["public_profile", "email", "user_friends"]

        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()

        
        
    }
    
    func goToNextPage() {
        self.performSegueWithIdentifier("SelectUsernameSegue", sender: self)
    }
    
    func presentError(msg:String) {
        let alert = HSAlertMessageFactory.createMessage(.Error, msg: msg).onOk({_ in})
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        
        if (error == nil) {
            print("Did enter Google sign In")
            let authentication = user.authentication
            let credential = FIRGoogleAuthProvider.credentialWithIDToken(authentication.idToken, accessToken: authentication.accessToken)
            FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                
                if error == nil {
                    print("Hello \(user?.displayName)")
                    self.goToNextPage()
                } else {
                    self.presentError(error!.localizedDescription)
                }
                
            }
        } else {
            self.presentError(error!.localizedDescription)
        }
        
    }
    
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
        try! FIRAuth.auth()!.signOut()
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
        let handled: Bool = FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
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

extension LoginViewController: FBSDKLoginButtonDelegate{
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if error == nil {
            print("Did enter facebook login")
            let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
            FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                if error == nil {
                    self.goToNextPage()
                } else {
                    self.presentError(error!.localizedDescription)
                }
                
            }
        } else {
            self.presentError(error!.localizedDescription)
        }
        
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        try! FIRAuth.auth()!.signOut()
    }
}
