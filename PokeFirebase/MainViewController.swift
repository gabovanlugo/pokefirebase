//
//  MainViewController.swift
//  PokeFirebase
//
//  Created by Gabo Lugo on 9/12/16.
//  Copyright © 2016 Gabo Lugo. All rights reserved.
//

import UIKit
import Spring
import Firebase

class MainViewController: UIViewController {
    
    let rootRef = FIRDatabase.database().reference()
    var logItems = [LogItem]()
    
    var currentUid = ""
    var currentTwitterId = ""
    
    var capturedRef = FIRDatabaseReference()
    
    @IBOutlet weak var stageCollectionView: UICollectionView!
    
    @IBAction func trainerButton(sender: AnyObject) {
        //
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        observeAdded()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        print("Here, again!")
        
        capturedRef.removeAllObservers()
    }
    
    override func viewWillLayoutSubviews() {
        stageCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    func observeAdded() {
        
        let logRef = rootRef.child("log")
        
        logRef.observeEventType(.ChildAdded, withBlock: { (snapshot) in
            
            let logItem = LogItem()
            
            logItem.name = snapshot.value!["name"] as! String
            logItem.pokemonId = snapshot.value!["pokemonId"] as! Int
            logItem.twitterId = snapshot.value!["twitterId"] as! String
            logItem.uid = snapshot.value!["uid"] as! String
            
            // Photo URL Manipulation
            let insecureUrl = snapshot.value!["photoUrl"] as! String
            let secureUrl = insecureUrl.stringByReplacingOccurrencesOfString("http", withString: "https")
            
            let biggerPhotoUrl = secureUrl.stringByReplacingOccurrencesOfString("_normal.", withString: "_bigger.")
            
            logItem.photoUrl = biggerPhotoUrl
            
            
            
            
            self.stageCollectionView.performBatchUpdates({
                
                self.logItems.append(logItem)
                
                let last = self.stageCollectionView.numberOfItemsInSection(0)
                let lastIndexPath = NSIndexPath(forItem: last, inSection: 0)
                
                self.stageCollectionView.insertItemsAtIndexPaths([lastIndexPath])
                
                if last > 0 {
                    dispatch_async(dispatch_get_main_queue(), {
                        let indexPath = NSIndexPath(forItem: self.stageCollectionView.numberOfItemsInSection(0) -  1, inSection: 0)
                        self.stageCollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
                    })
                }
                
                
                }, completion: { (finished: Bool) in
                    self.stageCollectionView.reloadData()
            })
            
            
        }, withCancelBlock: nil)
        
    }
    
    
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Show Trainer" {
            let vc = segue.destinationViewController as! TrainerViewController
            
            vc.twitterUserID = currentTwitterId
            vc.uid = currentUid
            
            capturedRef = rootRef.child("users/\(currentUid)/captures")
            
            vc.capturedRef = capturedRef
            
        }
        
    }

    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return logItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MainCollectionViewCell
        let i = indexPath.row
  
        // Customize UI
        shadowElement(cell.pokemonImage, color: "000000", opacity: 0.2, radius: 10.0)
        shadowElement(cell, color: "000000", opacity: 0.1, radius: 5.0)
        cell.layer.masksToBounds = false
        cell.pokemonImage.contentMode = UIViewContentMode.ScaleAspectFit
        cell.trainerImage.contentMode = UIViewContentMode.ScaleAspectFit
        cell.trainerImage.layer.cornerRadius = 30.0
        cell.trainerImage.layer.masksToBounds = true
        
        
        // Read DataSource
        
        cell.trainerLabel.text = logItems[i].name
        cell.pokemonLabel.text = pokemon.get(logItems[i].pokemonId - 1)
        
        cell.trainerImage.kf_setImageWithURL(NSURL(string: "\(logItems[i].photoUrl)")!, placeholderImage: nil)
        
        cell.pokemonImage.image = UIImage(named: "\(logItems[i].pokemonId)")
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellHeight = 100
        return CGSizeMake(collectionView.bounds.size.width - 20.00, CGFloat(cellHeight))
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let i = indexPath.row
        
        currentTwitterId = logItems[i].twitterId
        currentUid = logItems[i].uid
        
        performSegueWithIdentifier("Show Trainer", sender: self)
    }
    
}


class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var trainerImage: UIImageView!
    @IBOutlet weak var trainerLabel: UILabel!
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonLabel: UILabel!
}
