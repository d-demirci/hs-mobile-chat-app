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
import FBSDKLoginKit
import TwitterKit
import Fabric

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
		
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
//        Twitter.sharedInstance().startWithConsumerKey("4RwYP0VbsgWTHuLVIdU2P9zXv", consumerSecret: "64Jc8dLJthSn4cRckxQ6QBchKbUsxJtflnRUcC1hFChhrA4qsp")
        Fabric.with([Twitter.self()])
        
        do {
            try FIRAuth.auth()?.signOut()

        }catch {
            
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if FIRAuth.auth()?.currentUser != nil {
            goToChat()
        }
        
    }
    
    func goToChat() {
        let chatStoryboard = UIStoryboard(name: "Chat", bundle: nil)
        let chatNavController = chatStoryboard.instantiateViewControllerWithIdentifier("NavigationChat")
        self.showViewController(chatNavController, sender: self)
    }
    
    func goToSetUsername() {
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
                    self.goToSetUsername()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnFBLoginPressed(sender: UIButton) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager .logInWithReadPermissions(["public_profile", "email", "user_friends"], fromViewController: self, handler: { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                    let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
                    self.loginToFirebase(credential)
                    fbLoginManager.logOut()
                }
            }
        })
    }
    
    @IBAction func btnTWRTLoginPressed(sender: UIButton) {
        
        
        
        Twitter.sharedInstance().logInWithCompletion {
            (session, error) -> Void in
            if (session != nil) {

                let credential = FIRTwitterAuthProvider.credentialWithToken(session!.authToken, secret: session!.authTokenSecret)

                self.loginToFirebase(credential)
                
            } else {
                print("error: \(error!.localizedDescription)");
            }
        }
    }
    
    
    @IBAction func btnGoogleLoginPressed(sender: UIButton) {
        
        GIDSignIn.sharedInstance().signIn()
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                    print(result)
                }
            })
        }
    }
    
    func loginToFirebase(credential: FIRAuthCredential){
        FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
            if error == nil {
                self.goToSetUsername()
            } else {
                self.presentError(error!.localizedDescription)
            }
            
        }

    }

}

