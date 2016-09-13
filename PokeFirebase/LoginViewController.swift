//
//  LoginViewController.swift
//  PokeFirebase
//
//  Created by Gabo Lugo on 9/12/16.
//  Copyright © 2016 Gabo Lugo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import TwitterKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let loginButton = TWTRLogInButton { (session, error) in
            
            if session != nil {
                let authToken = session?.authToken
                let secret = session?.authTokenSecret
                
                // Firebase Twitter Auth
                let credential = FIRTwitterAuthProvider.credentialWithToken(authToken!, secret: secret!)
                FIRAuth.auth()?.signInWithCredential(credential, completion: { (user, error) in
                    if error != nil {
                        print(error)
                        return
                    }
                    
                    print("User logged in with Twitter.")
                    print(session?.userName)
                    
                    // Segue to Main Controller
                    self.performSegueWithIdentifier("Show Main", sender: nil)
                    
                    
                })
                
                
            } else {
                if error != nil {
                    print(error)
                    return
                }
            }
        }
        
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
