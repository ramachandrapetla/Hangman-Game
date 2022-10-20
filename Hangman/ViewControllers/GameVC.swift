//
//  GameVC.swift
//  Hangman
//
//  Created by Ramachandra petla on 9/14/22.
//

import UIKit

class GameVC: UIViewController {

    @IBOutlet weak var lblGuessWord: UILabel!
    var guessWord = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblGuessWord.text = guessWord
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
