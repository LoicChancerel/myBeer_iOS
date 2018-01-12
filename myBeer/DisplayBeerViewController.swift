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
    var db: DatabaseAccess!
    
    @IBOutlet weak var displayBeerName: UILabel!
    @IBOutlet weak var displayBeerNote: UILabel!
    @IBOutlet weak var displayBeerStrength: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.db = DatabaseAccess()
        displayBeerName.text = beer.getName()
        displayBeerStrength.text = String(beer.getStrength())
        displayBeerNote.text = String(beer.getNote())

        // Do any additional setup after loading the view.
    }

    @IBAction func deleteBeerOnClick(_ sender: UIButton) {
            let alertController = UIAlertController(title: "Supprimer un élément", message: "Voulez vous vraiment supprimer l'élément \(self.beer.getName()) ?", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Valider", style: .default, handler: { (action) in
            do {
                try self.db.deleteBeer(beer: self.beer)
                print("Beer deleted successfully !")
                self.navigationController?.popViewController(animated: true)
            } catch {
                print(error)
            }
        }))
        
        self.present(alertController, animated: true, completion: nil)
            
    }
    
    @IBAction func editBeerOnClick(_ sender: UIButton) {
        let alert = UIAlertController(title: "Modifier une bière", message: "Dans l'ordre : le nom, les degrés et votre note", preferredStyle: .alert)
        alert.addTextField { (tf) in
            tf.text = self.beer.getName()
        }
        alert.addTextField { (tf) in
            tf.text = String(self.beer.getStrength())
        }
        alert.addTextField { (tf) in
            tf.text = String(self.beer.getNote())
        }
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Valider", style: .default, handler: { (action) in
            guard let beerName = alert.textFields?[0].text,
                let beerStrength = Double(alert.textFields![1].text!),
                let beerNote = Double(alert.textFields!.last!.text!)
                else { return }
            
            let beerChanged = Beer(id: self.beer.getId(), name: beerName, strength: beerStrength, note: beerNote)
            self.db.updateBeer(beer: beerChanged)
            self.beer = beerChanged
            self.viewDidLoad()
        }))
        
        self.present(alert, animated: true, completion: nil)
        
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
