//
//  GameVC.swift
//  Hangman
//
//  Created by Ramachandra petla on 9/14/22.
//

import UIKit

class GameVC: UIViewController {

    @IBOutlet weak var imgViewHangman: UIImageView!
    @IBOutlet weak var lblGuessWord: UILabel!
    
    
    var guessWord = ""
    var curGuessCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createHiddenWord()
    }
    

    @IBAction func btnAction(_ sender: Any) {
        let btn = sender as! UIButton
        btn.isEnabled = false
        updateWord(revealLetter: btn.titleLabel!.text!.lowercased())

    }
    
    func createHiddenWord() {
        var hiddenWord = ""
        for _ in guessWord {
            hiddenWord = hiddenWord + "_ "
        }
        lblGuessWord.text = hiddenWord
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }


    func updateWord(revealLetter:String) {
        if guessWord.contains(revealLetter) {
            var hiddenWord = lblGuessWord.text
            var counter = 0
            for ch in guessWord {
                if ch == Array(revealLetter)[0] {
                    var chars = Array(hiddenWord!)
                    chars[counter] = Array(revealLetter)[0]
                    hiddenWord = String(chars)
                }
                counter = counter + 1
            }
            lblGuessWord.text = hiddenWord
            
            if hiddenWord == guessWord {
                showAlert(title: "Win", message: "Congratulations, You won!")
            }
        }
        else {
            curGuessCount = curGuessCount + 1
            
            if curGuessCount <= 10 {
                imgViewHangman.image = UIImage(named: String(curGuessCount))
            }
            else {
                showAlert(title: "Lost", message: "Sorry, You lost! The word is " + guessWord)
            }
        }
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
