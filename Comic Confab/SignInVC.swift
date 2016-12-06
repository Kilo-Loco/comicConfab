//
//  ViewController.swift
//  Comic Confab
//
//  Created by Kyle Lee on 9/30/16.
//  Copyright © 2016 Kyle Lee. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailTF: MaterialTextField!
    
    @IBOutlet weak var passwordTF: MaterialTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let keychain = KeychainWrapper.defaultKeychainWrapper().stringForKey(KEY_UID) {
            print(keychain)
            self.performSegue(withIdentifier: "SignInToFeed", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookButtonTapped(_ sender: AnyObject) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("KYLE: FACEBOOK AUTHENTICATION FAILURE \(error.debugDescription)")
            } else if result?.isCancelled == true {
                print("KYLE: FACEBOOK USER CANCELLED FACEBOOK AUTHENTICATION")
            } else {
                print("KYLE: FACEBOOK SUCCESSFUL AUTHENTICATION")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuthentication(credential)
                
            }
        }
        
    }
    
    func firebaseAuthentication(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("KYLE: FIREBASE AUTHENTICATION FAILURE \(error)")
            } else {
                print("KYLE: FIREBASE SUCCESSFUL AUTHENTICATION")
                guard let user = user else { return }
                let userData = ["provider": credential.provider]
                self.completeSignIn(user.uid, userData: userData)
            }
        })
    }
    
    
    @IBAction func onSignInButtonTapped(_ sender: AnyObject) {
        guard let email = self.emailTF.text, let password = self.passwordTF.text else { return }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                print("KYLE: EMAIL AUTHENTICATED WITH FIREBASE")
                guard let user = user else { return }
                let userData = ["provider": user.providerID]
                self.completeSignIn(user.uid, userData: userData)
            } else {
                FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                    if error != nil {
                        print("KYLE: UNABLE TO AUTHENTICATE WITH FIREBASE USING EMAIL")
                    } else {
                        print("KYLE: SUCCESSFULLY CREATED AUTHENTICATED WITH FIREBASE")
                        guard let user = user else { return }
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(user.uid, userData: userData)
                    }
                })
            }
        })
    }
    
    func completeSignIn(_ id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        let keychain = KeychainWrapper.defaultKeychainWrapper().setString(id, forKey: KEY_UID)
        print("KYLE: USER INFO SAVED TO KEYCHAIN \(keychain)")
        self.performSegue(withIdentifier: "SignInToFeed", sender: nil)
    }
    
    @IBAction func unwindToSignIn(segue: UIStoryboardSegue) {}

}

