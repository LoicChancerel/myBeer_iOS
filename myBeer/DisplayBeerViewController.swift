//
//  DisplayBeerViewController.swift
//  myBeer
//
//  Created by CHANCEREL Loic on 12/01/2018.
//  Copyright © 2018 CHANCEREL Loic. All rights reserved.
//

import UIKit

class DisplayBeerViewController: UIViewController {
    
    var beer: Beer!
    var beerId: Int!
    
    @IBOutlet weak var displayBeerName: UILabel!
    @IBOutlet weak var displayBeerNote: UILabel!
    @IBOutlet weak var displayBeerStrength: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(beerId)
        displayBeerName.text = beer.getName()
        displayBeerStrength.text = String(beer.getStrength())
        displayBeerNote.text = String(beer.getNote())

        // Do any additional setup after loading the view.
    }

    @IBAction func deleteBeerOnClick(_ sender: UIButton) {
        do {
            let db = DatabaseAccess()
            try db.deleteBeer(beer: beer)
            self.dismiss(animated: true, completion: nil)
        } catch {
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
