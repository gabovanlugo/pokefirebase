//
//  TrainerViewController.swift
//  PokeFirebase
//
//  Created by Gabo Lugo on 9/12/16.
//  Copyright © 2016 Gabo Lugo. All rights reserved.
//

import UIKit

class TrainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
