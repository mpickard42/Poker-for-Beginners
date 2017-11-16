//
//  CardHomeViewController.swift
//  Poker for Beginners
//
//  Created by Marjorie Pickard on 10/26/17.
//  Copyright © 2017 E&M. All rights reserved.
//

import UIKit

class CardHomeViewController: UIViewController {
    struct Data {}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCardPress(_ sender: UIButton) {
        performSegue(withIdentifier: "cardSelectSegue", sender: self)
    }
    @IBAction func onResultsButtonPress(_ sender: UIButton) {
        performSegue(withIdentifier: "resultsViewSegue", sender: self)
    }

    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
