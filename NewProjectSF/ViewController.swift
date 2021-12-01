//
//  ViewController.swift
//  NewProjectSF
//
//  Created by Ксения Борисова on 16.11.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var expressionAndResultLabel: UILabel?
    
    var firstOperand: Float = 0
    var secondOperand: Float = 0
    var operatorSign = ""
    var stillTyping = false
    var dotIsInput = false
    var currentInput: Float {
        get {
            guard let val = expressionAndResultLabel?.text else {
                return 0
            }
            return Float(val) ?? 0
        }
        set {
            expressionAndResultLabel?.text = "\(newValue)"
            stillTyping = false
        }
    }
    
    @IBAction func numInput(_ sender: UIButton) {
        guard let text = expressionAndResultLabel?.text else { return }
        
        if sender.currentTitle! == "0" && currentInput == 0 {
            return
        }
        
        if stillTyping {
            if text.count < 30 {
                let inputNumber = sender.currentTitle!
                expressionAndResultLabel?.text = text + inputNumber
            }
        } else {
                expressionAndResultLabel?.text = sender.currentTitle!
                stillTyping = true
        }
    }
    

    
    @IBAction func invertInputNum(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func removeLastCharacter(_ sender: UIButton) {
        guard let text = expressionAndResultLabel?.text else { return }
        if text.count > 1 {
            expressionAndResultLabel?.text = String(text.dropLast())
        } else {
            expressionAndResultLabel?.text = "0"
            dotIsInput = false
        }
        
    }
    
    @IBAction func removeAllInput(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        operatorSign = ""
        currentInput = 0
        expressionAndResultLabel?.text = "0"
        stillTyping = false
        dotIsInput = false
    }
    
    
    @IBAction func pressedOperationWithTwoOperands(_ sender: UIButton) {
        operatorSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsInput = false
    }
    
    
    @IBAction func equalityButtonPresser(_ sender: UIButton) {
        
        if stillTyping {
            secondOperand = currentInput
        }
        switch operatorSign {
        case "+":
            let val = firstOperand + secondOperand
            expressionAndResultLabel?.text = val.truncatingRemainder(dividingBy: 1) == 0
            ? String(Int(val))
            : String(firstOperand + secondOperand)
            stillTyping = false
        case "−":
            let val = firstOperand - secondOperand
            expressionAndResultLabel?.text = val.truncatingRemainder(dividingBy: 1) == 0
            ? String(Int(val))
            : String(firstOperand - secondOperand)
            stillTyping = false
        case "×":
            let val = firstOperand * secondOperand
            expressionAndResultLabel?.text = val.truncatingRemainder(dividingBy: 1) == 0
            ? String(Int(val))
            : String(firstOperand * secondOperand)
            stillTyping = false
        case "÷":
            let val = firstOperand / secondOperand
            expressionAndResultLabel?.text = val.truncatingRemainder(dividingBy: 1) == 0
            ? String(Int(val))
            : String(firstOperand / secondOperand)
            stillTyping = false
        default:
            break
        }
        
    }
    
    @IBAction func dotButton(_ sender: UIButton) {
        guard let text = expressionAndResultLabel?.text else {
            return
        }
        if stillTyping && !text.contains(".") {
            expressionAndResultLabel?.text = text + "."
            dotIsInput = true
        } else if !stillTyping && !text.contains(".") {
            expressionAndResultLabel?.text = "0."
        }
    }
    
    @IBAction func percentButton(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            if stillTyping {
                secondOperand = currentInput
            }
            switch operatorSign {
            case "+" , "−" :
                expressionAndResultLabel?.text = String(firstOperand * (secondOperand/100))
                stillTyping = false

            case "×", "÷":
                expressionAndResultLabel?.text = String(secondOperand / 100)
                secondOperand = secondOperand / 100
                stillTyping = false

            default:
                break
            }
        }
    }
    
}
    

