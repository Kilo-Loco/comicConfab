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

class SignInVC: UIViewController {

    @IBOutlet weak var emailTF: MaterialTextField!
    
    @IBOutlet weak var passwordTF: MaterialTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
            }
        })
    }
    
    
    @IBAction func onSignInButtonTapped(_ sender: AnyObject) {
        guard let email = self.emailTF.text, let password = self.passwordTF.text else { return }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                print("KYLE: EMAIL AUTHENTICATED WITH FIREBASE")
            } else {
                FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                    if error != nil {
                        print("KYLE: UNABLE TO AUTHENTICATE WITH FIREBASE USING EMAIL")
                    } else {
                        print("KYLE: SUCCESSFULLY CREATED AUTHENTICATED WITH FIREBASE")
                    }
                })
            }
        })
        
        
        
        
    }
    
    

}

