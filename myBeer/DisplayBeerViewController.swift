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
    
    @IBOutlet weak var displayBeerName: UILabel!
    @IBOutlet weak var displayBeerNote: UILabel!
    @IBOutlet weak var displayBeerStrength: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayBeerName.text = beer.getName()
        displayBeerStrength.text = String(beer.getStrength())
        displayBeerNote.text = String(beer.getNote())

        // Do any additional setup after loading the view.
    }

    @IBAction func deleteBeerOnClick(_ sender: UIButton) {
            let db = DatabaseAccess()
            let alertController = UIAlertController(title: "Supprimer un élément", message: "Voulez vous vraiment supprimer l'élément \(self.beer.getName()) ?", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Valider", style: .default, handler: { (action) in
            do {
                try db.deleteBeer(beer: self.beer)
                print("Beer deleted successfully !")
                self.navigationController?.popViewController(animated: true)
            } catch {
                print(error)
            }
        }))
        
        self.present(alertController, animated: true, completion: nil)
            
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
