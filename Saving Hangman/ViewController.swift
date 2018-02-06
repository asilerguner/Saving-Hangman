//
//  ViewController.swift
//  Saving Hangman
//
//  Created by Asil Erguner on 2018-02-06.
//  Copyright © 2018 Asil Erguner. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    
    var allWords = [String]()
    var selectedWordArray = [String]()
    var selectedWord = ""
    var promptWord = ["🗙", "🗙", "🗙", "🗙", "🗙", "🗙", "🗙", "🗙"]
    var userEnteredLetter = ""
    var wrongEnteredArray = [String]()
    
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Create the view

        resetGame()
    }
    
    @IBAction func keyboardButtonPressed(_ sender: UIButton) {
        
        userEnteredLetter = (sender.titleLabel?.text)!
        print(userEnteredLetter)
        
        for i in 0 ..< selectedWordArray.count {
            if selectedWordArray[i].contains(userEnteredLetter) {
                promptWord[i] = String(userEnteredLetter)
            }
        }
        
        textField.text = promptWord.joined(separator: "")
        print(promptWord)
        
        if !selectedWordArray.contains(userEnteredLetter) {
            let wrongEnteredString = userEnteredLetter
            wrongEnteredArray.append(wrongEnteredString)
            print(wrongEnteredArray)
        }
        
        if wrongEnteredArray.count == 8 {
            print("End of game")
            textField.text = selectedWord
            showAlert(title: "You are dead! 😢")
        }
        

        if promptWord == selectedWordArray {
            print("Success")
            showAlert(title: "You survived! 😄")
        }
        
        switch wrongEnteredArray.count {
        case 1:
            imageView.image = UIImage(named: "1")
        case 2:
            imageView.image = UIImage(named: "2")
        case 3:
            imageView.image = UIImage(named: "3")
        case 4:
            imageView.image = UIImage(named: "4")
        case 5:
            imageView.image = UIImage(named: "5")
        case 6:
            imageView.image = UIImage(named: "6")
        case 7:
            imageView.image = UIImage(named: "7")
        case 8:
            imageView.image = UIImage(named: "8")
        default:
            imageView.image = UIImage(named: "0")
        }
        
        let meaningfullPromtWord = promptWord.filter { $0 != "🗙" }
        switch meaningfullPromtWord.count {
        case 1:
            progressLabel.text = "Progress: 12.5%"
        case 2:
            progressLabel.text = "Progress: 25.0%"
        case 3:
            progressLabel.text = "Progress: 37.5%"
        case 4:
            progressLabel.text = "Progress: 50.0%"
        case 5:
            progressLabel.text = "Progress: 62.5%"
        case 6:
            progressLabel.text = "Progress: 75.0%"
        case 7:
            progressLabel.text = "Progress: 87.5%"
        case 8:
            progressLabel.text = "Completed: 100.0%"
            showAlert(title: "You are alive!")
        default:
            progressLabel.text = "Progress: 0.0%"
        }
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        resetGame()
    }
    
    func showAlert(title: String) {
        let ac = UIAlertController(title: title, message: "Would you like to play a new game?", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: { (action) in
            self.resetGame()
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func resetGame() {
        helpButton.isEnabled = true
        helpButton.backgroundColor = #colorLiteral(red: 0.974732697, green: 0.3413235545, blue: 0.1757261157, alpha: 1)
        progressLabel.text = "0.0%"
        imageView.image = UIImage(named: "0")
        promptWord = ["🗙", "🗙", "🗙", "🗙", "🗙", "🗙", "🗙", "🗙"]
        textField.text = promptWord.joined(separator: "")
        textField.font = UIFont(name: "Avenir Next Heavy", size: 328)
        userEnteredLetter = ""
        wrongEnteredArray = [String]()
        
        var selectedWordIndex: Int
        
        if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
            if let startWords = try? String(contentsOfFile: startWordsPath) {
                allWords = startWords.components(separatedBy: "\n")
            } else {
                allWords = ["bigerror"]
            }
        } else {
            allWords = ["bigerror"]
        }
        
        selectedWordIndex = GKRandomSource.sharedRandom().nextInt(upperBound: allWords.count)
        selectedWord = (allWords[selectedWordIndex]).uppercased()
        selectedWordArray = selectedWord.map { String($0) }
        print(selectedWordArray)
    }
    
    @IBAction func helpButtonPressed(_ sender: UIButton) {
     let index = GKRandomSource.sharedRandom().nextInt(upperBound: selectedWord.count)
        let showLetter = selectedWordArray[index]
        
        if let i = selectedWordArray.index(of: showLetter) {
            promptWord[i] = showLetter
            textField.text = promptWord.joined(separator: "")
            helpButton.isEnabled = false
            helpButton.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        }
    }
}











