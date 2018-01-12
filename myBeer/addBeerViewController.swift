//
//  addBeerViewController.swift
//  myBeer
//
//  Created by CHANCEREL Loic on 20/12/2017.
//  Copyright © 2017 CHANCEREL Loic. All rights reserved.
//

import UIKit

class addBeerViewController: UIViewController {

    @IBOutlet weak var inputBeerName: UITextField!
    @IBOutlet weak var inputBeerStrength: UITextField!
    @IBOutlet weak var inputBeerNote: UITextField!
    
    let db: DatabaseAccess
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.db = DatabaseAccess()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.db = DatabaseAccess()
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonOnClick(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonOnClick(_ sender: UIBarButtonItem) {
        // Todo : save beer !
        let name = inputBeerName.text!
        let strength = Double(inputBeerStrength.text!)
        let note = Double(inputBeerNote.text!)
        
        let alertController = UIAlertController(title: "Oops", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        if name == "" {
            alertController.message = "Veuillez remplir le nom"
        } else if strength == nil || strength! > 90.0  {
            alertController.message = "Veuillez choisir un degré raisonnable"
        } else if note == nil || note! > 20.0 {
            alertController.message = "La notation se fait sur 20"
        } else{
            let newBeer = Beer.init(name: name, strength: strength!, note: note!)
            do {
                let beerSaved = try db.insertBeer(beer: newBeer)
                print("You saved the beer \(beerSaved.getName()) !")
                self.dismiss(animated: true, completion: nil)
            } catch {
                print(error)
            }
        }
    
        self.present(alertController, animated: true, completion: nil)
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
