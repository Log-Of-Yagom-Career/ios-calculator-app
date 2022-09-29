//
//  Calculator - ViewController.swift
//  Created by Baem. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var numberTextLabel: UILabel!
    @IBOutlet weak var operatorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        numberButtonTapped(sender.titleLabel?.text ?? "오류")
    }
    
    @IBAction func doubleZeroButtonTapped(_ sender: UIButton) {
        if numberTextLabel.text == "0" {
            numberTextLabel.text = "0"
        } else {
            numberTextLabel.text?.append("00")
        }
    }
    
    @IBAction func dotButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func operatorButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func equalButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func acButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func ceButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func signButtonTapped(_ sender: UIButton) {
    }
    
    func numberButtonTapped(_ text: String) {
        if numberTextLabel.text == "0" {
            numberTextLabel.text = text
        } else {
            numberTextLabel.text?.append(text)
        }
    }
}

