//
//  Calculator - ViewController.swift
//  Created by Baem. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var numberTextLabel: UILabel!
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var subScrollView: UIStackView!
    
    enum Dot {
        case able
        case disable
    }
    
    enum OperatorAble {
        case able
        case disable
    }
    
    var dotState = Dot.able
    var operatorAble = OperatorAble.able
    var operateResult: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberTextLabel.text = "0"
        operatorLabel.text = ""
    }
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        numberButtonTapped(sender.titleLabel?.text ?? "오류")
        operatorAble = .able
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
        
        switch operatorAble {
        case .able:
            operateResult += addOperandAndTransedOperator(operandText: operatorText, operatorText: numberText)
        case .disable:
            return
        }
        
        operatorLabel.text = sender.currentTitle
        numberTextLabel.text = "0"
        operatorAble = .disable
        dotState = .able
        
        //스크롤뷰 설정
        let stackview = addStackviewOfScrollView(numberText, operatorText)
        subScrollView.addArrangedSubview(stackview)
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height)
        scrollView.setContentOffset(bottomOffset, animated: true)
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
    
    func addStackviewOfScrollView(_ operandText: String, _ operatorText: String) -> UIStackView {
        let operatorLabel: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.font = .preferredFont(forTextStyle: .title3)
            label.text = operatorText
            
            return label
        }()
        
        let operandLabel: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.font = .preferredFont(forTextStyle: .title3)
            label.text = operandText
            
            return label
        }()
        
        let stackView = UIStackView()
        stackView.addArrangedSubview(operatorLabel)
        stackView.addArrangedSubview(operandLabel)
        
        return stackView
    }
}
