//
//  TrainerViewController.swift
//  PokeFirebase
//
//  Created by Gabo Lugo on 9/12/16.
//  Copyright © 2016 Gabo Lugo. All rights reserved.
//

import UIKit
import Firebase
import TwitterKit
import TwitterCore
import Kingfisher


class TrainerViewController: UIViewController {
    
    var twitterUserID = "" {
        didSet {
            print(twitterUserID)
        }
    }
    var uid = "" {
        didSet {
            print(uid)
        }
    }
    
    var capturedRef = FIRDatabaseReference()
    
    var pokemonArray = [Int]()
    
    @IBOutlet weak var trainerHandlename: UILabel!
    @IBOutlet weak var trainerImage: UIImageView!
    
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Twitter Handlename
        let store = Twitter.sharedInstance().sessionStore
        let userID = store.session()?.userID
        
        let twitterClient = TWTRAPIClient(userID: userID)
        
        twitterClient.loadUserWithID(twitterUserID) { (user, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            let handleName = user?.screenName
            let photoUrl = user?.profileImageLargeURL
            
            self.trainerHandlename.text = "@\(handleName!)"
            self.trainerImage.kf_setImageWithURL(NSURL(string: "\(photoUrl!)")!, placeholderImage: nil)
            self.trainerImage.layer.cornerRadius = 50.0
            self.trainerImage.layer.masksToBounds = true
        }
        
        observeChanges()
    }
    
    func observeChanges() {
        

        capturedRef.observeEventType(.Value, withBlock: { (snapshot) in
            
            print("Changed!")
            self.pokemonArray = []
            
            if snapshot.value is NSNull {
                print("Empty Snapshot")
                self.pokemonCollectionView.reloadData()
                return
            }
            
            for child in snapshot.children {
                
                let childSnapshot = snapshot.childSnapshotForPath(child.key)
                let pokemonId = childSnapshot.value!["pokemonId"] as! Int
                
                self.pokemonArray.append(pokemonId)
            }
            
            self.pokemonArray = self.pokemonArray.reverse()
            self.pokemonCollectionView.reloadData()
            
        })
        
        
    }

   

}

extension TrainerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("capturedCell", forIndexPath: indexPath) as! CapturedCollectionViewCell
        
        let i = indexPath.row
        
        // Customize UI
        cell.layer.masksToBounds = false
        cell.layer.borderColor = UIColor(hex: "F2F2F2").CGColor
        cell.layer.borderWidth = 0.5
        cell.capturedImage.contentMode = UIViewContentMode.ScaleAspectFit
        
        let pokemonId = pokemonArray[i]
        
        // Read Datasource
        cell.capturedImage.image = UIImage(named: "\(pokemonId)" )
        
        
        return cell
    }
    
}

class CapturedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var capturedImage: UIImageView!
}
