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
    
    @IBOutlet weak var trainerHandlename: UILabel!
    @IBOutlet weak var trainerImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Twitter Handlename
        let store = Twitter.sharedInstance().sessionStore
        let userID = store.session()?.userID
        
        let twitterClient = TWTRAPIClient(userID: userID)
        
        // Will change later
        let twitterUserID = userID!
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension TrainerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Sample
        return 10
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("capturedCell", forIndexPath: indexPath) as! CapturedCollectionViewCell
        
        // Customize UI
        cell.layer.masksToBounds = false
        cell.layer.borderColor = UIColor(hex: "F2F2F2").CGColor
        cell.layer.borderWidth = 0.5
        
        // Read Datasource
        cell.capturedImage.contentMode = UIViewContentMode.ScaleAspectFit
        
        return cell
    }
    
}

class CapturedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var capturedImage: UIImageView!
}
