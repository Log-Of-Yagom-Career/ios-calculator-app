//
//  Calculator - ViewController.swift
//  Created by Baem. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var numberTextLabel: UILabel!
    @IBOutlet weak var operatorLabel: UILabel!
    
    enum Dot {
        case able
        case disable
    }
    var dotState = Dot.able
    
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
        switch dotState {
        case .able:
            numberTextLabel.text?.append(".")
            dotState = .disable
        case .disable:
            break
        }
    }
    
    @IBAction func operatorButtonTapped(_ sender: UIButton) {
        operatorLabel.text = sender.currentTitle
        numberTextLabel.text = "0"
        dotState = .able
    }
    
    @IBAction func equalButtonTapped(_ sender: UIButton) {
        operatorLabel.text = nil
        numberTextLabel.text = "연산결과"
        dotState = .able
    }
    
    @IBAction func acButtonTapped(_ sender: UIButton) {
        numberTextLabel.text = "0"
        operatorLabel.text = nil
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

