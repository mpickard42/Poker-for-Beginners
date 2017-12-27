//
//  CardSelectViewController.swift
//  Poker for Beginners
//
//  Created by Marjorie Pickard on 10/26/17.
//  Copyright © 2017 E&M. All rights reserved.
//

import UIKit

class CardSelectViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var rankSuitPicker: UIPickerView!
    private let rankComponent = 0
    private let suitComponent = 1
    private let rankType = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
    private let suitType = ["Diamond", "Heart", "Club", "Spade"]
    var rank = 0
    var suit = 0
    var rankSuit = ["None", "None"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        rankSuitPicker.dataSource = self
        rankSuitPicker.delegate = self
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == rankComponent {
            return rankType[row]
        } else {
            return suitType[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == rankComponent {
            return rankType.count
        } else {
            return suitType.count
        }
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    @IBAction func submitButtonPress(_ sender: UIBarButtonItem) {
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == rankComponent {
            rank = row
        }else {
            suit = row
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sender = sender as? UIBarButtonItem {
            if sender.title == "Select" {
<<<<<<< HEAD
                rankSuit = [rankType[rank], suitType[suit]]
            }
=======
                rankSuit = [rankType[rank], String(suit)]
            } 
>>>>>>> 825787cebe5929299a85d9f6daf14ba6e10280da
        }
    }
}
