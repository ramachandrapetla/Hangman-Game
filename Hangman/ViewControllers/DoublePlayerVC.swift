//
//  DoublePlayerVC.swift
//  Hangman
//
//  Created by Ramachandra petla on 9/14/22.
//

import UIKit

class DoublePlayerVC: UIViewController {

    
    @IBOutlet weak var tfGuessWord: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnActionMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btnActionPlay(_ sender: Any) {
        performSegue(withIdentifier: "doubleplayer2game", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doubleplayer2game" {
            if let gameVC = segue.destination as? GameVC {
                if let enteredText = tfGuessWord.text {
                    gameVC.guessWord = enteredText
                }
            }
        }

    }

}
