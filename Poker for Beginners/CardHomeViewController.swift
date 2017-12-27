//
//  CardHomeViewController.swift
//  Poker for Beginners
//
//  Created by Marjorie Pickard on 10/26/17.
//  Copyright © 2017 E&M. All rights reserved.
//

import UIKit



class Card {
    var suit = 0
    var rank = 0
    var cardValue = 0
    
//    var SPADE = 4
//    var HEART = 3
//    var CLUB = 2
//    var DIAMOND = 1
//    
//    var Suit = ["*", "d", "c", "h", "s"]
//    var Rank = ["*", "A", "2", "3", "4","5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
    
    init(_ suit: Int, _ rank: Int) {
        self.suit = suit
        self.rank = rank
        cardValue = rank*10 + suit
    }
}

class CardHomeViewController: UIViewController {
    var senderButtonID = UIButton()
    var pc0 : Card?
    var pc1 : Card?
    var dc0 : Card?
    var dc1 : Card?
    var dc2 : Card?
    var dc3 : Card?
    var dc4 : Card?
    var cardsToPass : Array<Card> = []
    
    @IBOutlet weak var pc0Bttn: UIButton!
    @IBOutlet weak var pc1Bttn: UIButton!
    @IBOutlet weak var dc2Bttn: UIButton!
    @IBOutlet weak var dc3Bttn: UIButton!
    @IBOutlet weak var dc4Bttn: UIButton!
    @IBOutlet weak var dc0Bttn: UIButton!
    @IBOutlet weak var dc1Bttn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCardPress(_ sender: UIButton) {
        // Change to the CardSelectViewController page
        performSegue(withIdentifier: "cardSelectSegue", sender: self)
<<<<<<< HEAD
//        senderButtonID = sender
//        NSLog(String(describing: sender))
=======
        senderButtonID = sender
>>>>>>> 825787cebe5929299a85d9f6daf14ba6e10280da
    }
    @IBAction func onResultsButtonPress(_ sender: UIButton) {
        //Check that enough cards have been selected and that they are all different
        var cards = [pc0, pc1, dc0, dc1, dc2, dc3, dc4]  //all possible cards
        var pass = 1
        var failMessage = ""
        
        //Are first two cards selected
        if(pc0?.cardValue == nil || pc1?.cardValue == nil || pc0?.cardValue == 0 || pc1?.cardValue == 0){
            failMessage = "You must select your cards"
            pass = 0
        }else { //Move non nil cards into cardsToPass
            for i in 0 ..< cards.count {
                if cards[i] != nil && cards[i]?.cardValue != 0 {
                    cardsToPass.append(cards[i]!)
                }
            }
            if cardsToPass.count < 5 { //Make sure enough dealer cards are selected
                failMessage = "You must select at least 3 dealer dards"
                pass = 0
            }else { //Verify there are no duplicate cards
                for i in 0 ..< cardsToPass.count {
                    for j in i+1 ..< cardsToPass.count {
                        if cardsToPass[i].cardValue == cardsToPass[j].cardValue{
                            failMessage = "This hand could not exist"
                            pass = 0
                        }
                    }
                }
            }
        }

        if pass == 0 {
            cardsToPass = []
            let alert = UIAlertController(title: "You messed up",
                                          message: failMessage,
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default,
                                       handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }else {
            //Segue
            performSegue(withIdentifier: "resultsViewSegue", sender: self)
        }
    }

    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        if let returnedData = unwindSegue.source as? CardSelectViewController{
            //Stored as [rank, suit] both strings
            let rankSuit = returnedData.rankSuit
            if (rankSuit[0] != "None") {
                changeButtonPicture(rankSuit: rankSuit, senderButtonId: senderButtonID)
<<<<<<< HEAD
            }
=======
                saveCard(rankSuit: rankSuit, senderButtonId: senderButtonID)
            }
        }else {
            //reset card variables
            cardsToPass = []
>>>>>>> 825787cebe5929299a85d9f6daf14ba6e10280da
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "resultsViewSegue"){
            let vc = segue.destination as! ResultsViewController
            vc.cards = cardsToPass
        }
    }
    
<<<<<<< HEAD
    func changeButtonPicture (rankSuit: Array<String?>, senderButtonId: UIButton){
        NSLog("In Function")
        NSLog(String(describing: senderButtonID))
        senderButtonID.setBackgroundImage(UIImage(named: "blueButton copy"), for: .normal)
=======
    func changeButtonPicture (rankSuit: Array<Any>, senderButtonId: UIButton){
        let suits = ["D", "H", "C", "S"]
        if let rankSuit = rankSuit as? Array<String> {
            let imageName = rankSuit[0] + suits[Int(rankSuit[1])!]
            senderButtonID.setBackgroundImage(UIImage(named: imageName), for: .normal)
        }
    }
    
    @IBAction func clearCards(_ sender: Any) {
        let cardButtons = [pc0Bttn,pc1Bttn,dc0Bttn,dc1Bttn,dc2Bttn,dc3Bttn,dc4Bttn]
        for bttn in cardButtons {
            bttn?.setBackgroundImage(UIImage(named: "whiteButton copy"), for:.normal)
        }
        pc0?.cardValue = 0
        pc1?.cardValue = 0
        dc0?.cardValue = 0
        dc1?.cardValue = 0
        dc2?.cardValue = 0
        dc3?.cardValue = 0
        dc4?.cardValue = 0
    }
    func saveCard(rankSuit: Array<Any>, senderButtonId: UIButton) {
        if let rankSuit = rankSuit as? Array<String> {
            var rankInt = 0
            var suitInt = 0
            //Convert the suits- 
            //This was necessary because the order on the scroll bar 
            //was not the same as the order needed for the algorithm
            if(rankSuit[1] == "0") {
                suitInt = 1
            }else if(rankSuit[1] == "1") {
                suitInt = 3
            }else if(rankSuit[1] == "2"){
                suitInt = 2
            }else if(rankSuit[1] == "3"){
                suitInt = 4
            }
            
            //Convert the ranks- mostly just convert from string to int
            if(rankSuit[0] == "J"){
                rankInt = 11
            }else if(rankSuit[0] == "Q"){
                rankInt = 12
            }else if(rankSuit[0] == "K"){
                rankInt = 13
            }else if(rankSuit[0] == "A"){
                rankInt = 14
            }else {
                rankInt = Int(rankSuit[0])!
            }
            
            //Match the button clicked to the card variable name
            //pc - player card
            //dc - dealer card
            if(senderButtonID.restorationIdentifier == "pc0") {
                pc0 = Card(suitInt, rankInt)
            }else if(senderButtonID.restorationIdentifier == "pc1") {
                pc1 = Card(suitInt, rankInt)
            }else if(senderButtonID.restorationIdentifier == "dc0") {
                dc0 = Card(suitInt, rankInt)
            }else if(senderButtonID.restorationIdentifier == "dc1") {
                dc1 = Card(suitInt, rankInt)
            }else if(senderButtonID.restorationIdentifier == "dc2") {
                dc2 = Card(suitInt, rankInt)
            }else if(senderButtonID.restorationIdentifier == "dc3") {
                dc3 = Card(suitInt, rankInt)
            }else if(senderButtonID.restorationIdentifier == "dc4") {
                dc4 = Card(suitInt, rankInt)
            }
        }
>>>>>>> 825787cebe5929299a85d9f6daf14ba6e10280da
    }
}
