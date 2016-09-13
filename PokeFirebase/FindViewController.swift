//
//  FindViewController.swift
//  PokeFirebase
//
//  Created by Gabo Lugo on 9/12/16.
//  Copyright © 2016 Gabo Lugo. All rights reserved.
//

import UIKit

class FindViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func find(sender: AnyObject) {
        print("Searching Pókemon...")
        
        
        let delay = 0.5 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue()) {
            let id = self.getPokemonId();
            
            self.foundPokemonImage.image = UIImage(named: "\(id)")
            self.foundPokemonImage.contentMode = UIViewContentMode.ScaleAspectFit
            self.foundPokemonLabel.text = pokemon.get(id-1)
            
            print("Got \(id)");
        }
        
    }
    
    @IBOutlet weak var foundPokemonImage: UIImageView!
    
    @IBOutlet weak var foundPokemonLabel: UILabel!
    
    
    // Random Pókemon Generator
    
    func getPokemonId() -> Int {
        return Int(arc4random_uniform(150) + 1)
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
