//
//  ViewController.swift
//  Flashcard App
//
//  Created by Rezwan Reza on 9/17/22.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}


class ViewController: UIViewController {


    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
   
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    

    var flashcards = [Flashcard]()

    var currentIndex = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        if flashcards.count == 0 {
            updateFlashcard(question: "What are the primary colors?", answer: "Red,Yellow,Blue")
        } else {
            updateLabels()
            updateNextPrevButtons()
            
        }
        
        updateFlashcard(question: "What are the primary colors?", answer: "Red,Yellow,Blue")
    
    }

    func updateLabels() {
       
        let currentFlashcard = flashcards[currentIndex]
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
   
    @IBAction func didTapOnFlashcard(_ sender: Any){
    
        frontLabel.isHidden.toggle()
    
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
 
        currentIndex = currentIndex - 1
        
        updateLabels()
        
        updateNextPrevButtons()
    
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
  
        currentIndex = currentIndex + 1
        
        updateLabels()
        
        updateNextPrevButtons()
    
    }
    

    func updateFlashcard(question: String, answer: String) {
 
    let flashcard = Flashcard( question: question, answer: answer)
      
        flashcards.append(flashcard)
        
        print("Added a new Flashcard, take a look -> ", flashcards)
    
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
    
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
    
        updateNextPrevButtons()
        
        updateLabels()
    
      
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let navigationController = segue.destination as! UINavigationController
         let creationController = navigationController.topViewController as! CreationViewController
         creationController.flashcardsController = self
    }

    func updateNextPrevButtons() {
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
        nextButton.isEnabled = true

      }
     
            }

    func saveAllFlashcardsToDisk(){
        
        UserDefaults.standard.set(flashcards, forKey: "flashcards")
        
        let dictionaryArray = flashcards.map {(card) -> [String: String] in return ["question": card.question, "answer": card.answer]
        }
            UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcads saved to UserDefaults")
        
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String : String]] {

        }
        
        let savedCards = dictionaryArray.map {dictionary -> Flashcard in return Flashcard(question : dictionary ["dictionary"]!, answer: dictionary ["answer"]!)
        }
            flashcards.append(contentsOf : savedCards)
        
        }
    }
    


    

