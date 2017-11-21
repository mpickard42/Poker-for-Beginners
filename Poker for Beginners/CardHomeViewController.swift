//
//  CardHomeViewController.swift
//  Poker for Beginners
//
//  Created by Marjorie Pickard on 10/26/17.
//  Copyright © 2017 E&M. All rights reserved.
//

import UIKit

class CardHomeViewController: UIViewController {
    var senderButtonID = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCardPress(_ sender: UIButton) {
        // Change to the CardSelectViewController page
        performSegue(withIdentifier: "cardSelectSegue", sender: self)
//        senderButtonID = sender
//        NSLog(String(describing: sender))
    }
    @IBAction func onResultsButtonPress(_ sender: UIButton) {
        // Change to the ResultsViewController page
        performSegue(withIdentifier: "resultsViewSegue", sender: self)
    }

    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        if let returnedData = unwindSegue.source as? CardSelectViewController{
            //Display the returned data.  Stored as [rank, suit] both strings
            NSLog("Rank: " + String(describing: returnedData.rankSuit[0]) + ", Suit: " + String(describing: returnedData.rankSuit[1]))
            let rankSuit = returnedData.rankSuit
            if (rankSuit[0] != "None") {
                changeButtonPicture(rankSuit: rankSuit, senderButtonId: senderButtonID)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "cardSelectSegue"){
//            let vc = segue.destination as! CardSelectViewController
//            vc.buttonID = senderButtonID
//        }
    }
    
    func changeButtonPicture (rankSuit: Array<String?>, senderButtonId: UIButton){
        NSLog("In Function")
        NSLog(String(describing: senderButtonID))
        senderButtonID.setBackgroundImage(UIImage(named: "blueButton copy"), for: .normal)
    }
}
