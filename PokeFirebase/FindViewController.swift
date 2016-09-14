//
//  FindViewController.swift
//  PokeFirebase
//
//  Created by Gabo Lugo on 9/12/16.
//  Copyright © 2016 Gabo Lugo. All rights reserved.
//

import UIKit
import Firebase

class FindViewController: UIViewController {
    
    let rootRef = FIRDatabase.database().reference()
    
    struct userData {
        var uid = ""
        var name = ""
        var photoUrl = ""
        var twitterId = ""
    }
    
    var currentUserData = userData()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Get current user session data
        
        if let user = FIRAuth.auth()?.currentUser {
            
            var twitterId = ""
            
            for profile in user.providerData {
                twitterId = profile.uid;  // Provider-specific UID
            }
            
            self.currentUserData.uid = user.uid
            self.currentUserData.name = user.displayName!
            self.currentUserData.photoUrl = String(user.photoURL!)
            self.currentUserData.twitterId = twitterId
        } else {
            // No user is signed in.
        }
        
    }

    @IBOutlet weak var foundPokemonImage: UIImageView!
    
    @IBOutlet weak var foundPokemonLabel: UILabel!
    
    @IBAction func find(sender: AnyObject) {
        find()
    }
    
    
    // Find Pókemon
    
    func find() {
        print("Searching Pókemon...")
        
        let delay = 0.5 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue()) {
            let id = self.getPokemonId();
            
            self.foundPokemonImage.image = UIImage(named: "\(id)")
            self.foundPokemonImage.contentMode = UIViewContentMode.ScaleAspectFit
            self.foundPokemonLabel.text = pokemon.get(id-1)
            
            print("Got \(id)");
            
            // Save it
            self.save(id)
        }
    }
    
    // Random Pókemon Generator
    func getPokemonId() -> Int {
        return Int(arc4random_uniform(150) + 1)
    }
    
    // Save to Firebase Database
    func save(pokemonId: Int) {
        
        // /log
        
        let logRef = rootRef.child("log")
        let logKey = logRef.childByAutoId().key
        
        let values = [
            "pokemonId": pokemonId,
            "uid": currentUserData.uid,
            "name": currentUserData.name,
            "photoUrl": currentUserData.photoUrl,
            "twitterId": currentUserData.twitterId
        ]
        
        logRef.child(logKey).setValue(values)
        
        
        // /users/:id/captures/
        
        let userRef = rootRef.child("users/\(currentUserData.uid)/captures")
        let captureKey = userRef.childByAutoId().key
        
        userRef.child(captureKey).setValue(["pokemonId": pokemonId])
        
        
        
        
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
