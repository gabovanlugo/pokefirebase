//
//  MainViewController.swift
//  PokeFirebase
//
//  Created by Gabo Lugo on 9/12/16.
//  Copyright © 2016 Gabo Lugo. All rights reserved.
//

import UIKit
import Spring

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        stageCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    @IBOutlet weak var stageCollectionView: UICollectionView!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Sample
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MainCollectionViewCell
  
        // Customize UI
        shadowElement(cell.pokemonImage, color: "000000", opacity: 0.2, radius: 10.0)
        shadowElement(cell, color: "000000", opacity: 0.1, radius: 5.0)
        cell.layer.masksToBounds = false
        cell.pokemonImage.contentMode = UIViewContentMode.ScaleAspectFit
        
        // Read DataSource
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellHeight = 100
        return CGSizeMake(collectionView.bounds.size.width - 20.00, CGFloat(cellHeight))
    }
    
}


class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var trainerImage: UIImageView!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonLabel: UILabel!
}
