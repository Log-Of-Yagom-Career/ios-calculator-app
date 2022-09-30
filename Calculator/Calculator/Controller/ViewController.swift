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
    var operateResult: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberTextLabel.text = "0"
        operatorLabel.text = ""
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
        guard let numberText = numberTextLabel.text,
              let operatorText = operatorLabel.text else { return }
        
        operateResult += addOperandAndTransedOperator(operandText: operatorText, operatorText: numberText)
        //스크롤뷰에 operatorText  numberText 추가
        
        operatorLabel.text = sender.currentTitle
        numberTextLabel.text = "0"
        dotState = .able
    }
    
    @IBAction func equalButtonTapped(_ sender: UIButton) {
        guard let numberText = numberTextLabel.text,
              let operatorText = operatorLabel.text else { return }
        operatorLabel.text = ""
        operateResult += addOperandAndTransedOperator(operandText: operatorText, operatorText: numberText)
        
        do {
            var queue = try ExpressionParser.parse(from: operateResult)
            numberTextLabel.text = try String(queue.result())
            dotState = .able
            operateResult = ""
            
        } catch OperatorError.notUseZero {
            numberTextLabel.text = "NaN"
        } catch FormulaError.hasNotOperandValue, FormulaError.hasNotOperatorValue {
            print("Not operator, Operand")
        } catch FormulaError.isNotDouble {
            print("Not Double")
        } catch FormulaError.notValidCountQueue {
            print("NotValidCountQueue")
        } catch ExpressionParserError.canNotChangeDouble{
            print("CanNotChangeDouble")
        } catch {
            print("Another Error")
        }
        
        operateResult = ""
    }
    
    @IBAction func acButtonTapped(_ sender: UIButton) {
        numberTextLabel.text = "0"
        operatorLabel.text = ""
    }
    
    @IBAction func ceButtonTapped(_ sender: UIButton) {
        numberTextLabel.text = "0"
    }
    
    @IBAction func signButtonTapped(_ sender: UIButton) {
        guard let label = numberTextLabel.text else { return }
        
        if label.first == "-" {
            numberTextLabel.text?.removeFirst()
        } else if label != "0" {
            numberTextLabel.text = "-" + label
        }
    }
    
    func numberButtonTapped(_ text: String) {
        if numberTextLabel.text == "0" {
            numberTextLabel.text = text
        } else {
            numberTextLabel.text?.append(text)
        }
    }
    
    func addOperandAndTransedOperator(operandText: String, operatorText: String) -> String {
        var transedOperatorText: String
        
        switch operandText {
        case "+":
            transedOperatorText = "+"
        case "−":
            transedOperatorText = "-"
        case "×":
            transedOperatorText = "*"
        case "÷":
            transedOperatorText = "/"
        default:
            transedOperatorText = operandText
        }
        
        return " " + transedOperatorText + " " + operatorText
    }
}

