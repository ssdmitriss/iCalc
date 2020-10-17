//
//  CalculatorViewController.swift
//  Complex Calc
//
//  Created by Дмитрий Селезнев on 06.06.2020.
//  Copyright © 2020 Дмитрий Селезнев. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet var pasteButtons: [UIButton]!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet var actionButtons: [UIButton]!
    
    @IBOutlet var resultTextViews: [UITextView]!
    @IBOutlet var resultViews: [UIView]!
    
    @IBOutlet var firstNumTextFields: [UITextField]!
    @IBOutlet var secondNumTextFields: [UITextField]!
    
    @IBOutlet var angleLabels: [UILabel]!
    @IBOutlet weak var actionLabel: UILabel!
    
    private let calculator = Calculator.shared
    private let converter = Converter.shared
    
    private var complexNum: ComplexNum?
    private var generalNum: GeneralComplexNum?
    private var expNum: ExpComplexNum?
   
    
    private var clearPasteIndincator = true
    
    @IBOutlet weak var calculationMethodStackView: UIStackView!
    @IBOutlet var allVerticalConstraints: [NSLayoutConstraint]!
    
    
    override func updateViewConstraints() {
        
        if (812...896).contains(self.view.frame.size.height) {
            
        } else if view.layer.bounds.height == 667 {
            allVerticalConstraints[0].constant = 24
            allVerticalConstraints[5].constant = 48
            allVerticalConstraints[6].constant = 32
        } else if self.view.frame.size.height == 568 {
            allVerticalConstraints.forEach { constraint in
                constraint.constant /=  2
            }
            allVerticalConstraints[0].constant = 11
            calculationMethodStackView.spacing = 8
            let сonstraints = NSLayoutConstraint(item: calculationMethodStackView as Any,
                                                  attribute: .right,
                                                  relatedBy: .equal,
                                                  toItem: self.view,
                                                  attribute: .right,
                                                  multiplier: 1,
                                                  constant: -16)
            self.view.addConstraint(сonstraints)
        }
        
        super.updateViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in resultViews {
            i.layer.cornerRadius = 35 / 4
        }
        setupButtons()
        setupTextViews()
        setupTextFields()
        setupLabels()
    }
    
    private func setupButtons() {
        // Paste, copy, clear
        for button in pasteButtons {
            button.layer.cornerRadius = button.frame.height / 4
            button.backgroundColor = .lightGray
            button.setTitle("clear", for: .normal)
        }
        copyButton.layer.cornerRadius = copyButton.frame.height / 4
        clearButton.layer.cornerRadius = clearButton.frame.height / 4
        clearButton.backgroundColor = .lightGray
        // Action buttons
        for button in actionButtons {
            button.layer.cornerRadius = button.frame.height / 4
        }
        actionButtons[2].setTitle("\u{00D7}", for: .normal)
        actionButtons[3].setTitle("\u{00F7}", for: .normal)
    }
    
    private func setupTextViews() {
        
        for texView in resultTextViews {
            texView.layer.cornerRadius = texView.frame.height / 4
            //            texView.textContainer.maximumNumberOfLines = 1
        }
        resultTextViews[0].text = "a + i\u{00B7}b"
        resultTextViews[0].textColor = .opaqueSeparator
        resultTextViews[1].text = "A \u{2220} \u{03C6}\u{00B0}"
        resultTextViews[1].textColor = .opaqueSeparator
    }
    
    private func setupLabels() {
        for label in angleLabels {
            label.text = "\u{2220}"
        }
        actionLabel.text = "+ - \u{00D7} \u{00F7}"
        actionLabel.alpha = 0.22
    }
    
    private func setupTextFields() {
        firstNumTextFields[3].placeholder = "\u{03C6}\u{00B0}"
        secondNumTextFields[3].placeholder = "\u{03C6}\u{00B0}"
        
        for i in firstNumTextFields {
            i.keyboardType = .numberPad
            i.keyboardAppearance = .default
        }
        for i in secondNumTextFields {
            i.keyboardType = .numberPad
            i.keyboardAppearance = .default
        }
    }
    
    private func showResult(with complexNum: ComplexNum) {
        if complexNum.gneralForm.imaginaryNum >= 0 {
            resultTextViews[0].text = "\(Double(String(format: "%.\(roundingValue)f", complexNum.gneralForm.realNum))!) + i\u{00B7}\(Double(String(format: "%.\(roundingValue)f", complexNum.gneralForm.imaginaryNum))!)"
        } else {
            resultTextViews[0].text = "\(Double(String(format: "%.\(roundingValue)f", complexNum.gneralForm.realNum))!) - i\u{00B7}\(Double(String(format: "%.\(roundingValue)f", complexNum.gneralForm.imaginaryNum * (-1)))!)"
        }
        resultTextViews[1].text = "\(Double(String(format: "%.\(roundingValue)f", complexNum.expForm.module))!) \u{2220} \(Double(String(format: "%.\(roundingValue)f", complexNum.expForm.argument))!)\u{00B0}"
        
        for text in resultTextViews {
            text.textColor = .black
        }
    }
    
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            guard let complexNumber = calculator.makeAddition(
                    firstRealNum: firstNumTextFields[0],
                    firstImaginaryNum: firstNumTextFields[1],
                    firstModuleNum: firstNumTextFields[2],
                    firstArgumentNum: firstNumTextFields[3],
                    secondRealNum: secondNumTextFields[0],
                    secondImaginaryNum: secondNumTextFields[1],
                    secondModuleNum: secondNumTextFields[2],
                    secondArgumentNum: secondNumTextFields[3],
                    wrongFormatAlert: {
                        self.view.endEditing(true)
                        wrongFormatAlert()
                    }) else { return }
            complexNum = complexNumber
            showResult(with: complexNum!)
            actionLabel.alpha = 1
            actionLabel.text = actionButtons[0].titleLabel?.text
            self.view.endEditing(true)
            
        case 1:
            guard let complexNumber = calculator.makeSubtraction(
                    firstRealNum: firstNumTextFields[0],
                    firstImaginaryNum: firstNumTextFields[1],
                    firstModuleNum: firstNumTextFields[2],
                    firstArgumentNum: firstNumTextFields[3],
                    secondRealNum: secondNumTextFields[0],
                    secondImaginaryNum: secondNumTextFields[1],
                    secondModuleNum: secondNumTextFields[2],
                    secondArgumentNum: secondNumTextFields[3],
                    wrongFormatAlert: {
                        self.view.endEditing(true)
                        wrongFormatAlert()
                    }) else { return }
            complexNum = complexNumber
            showResult(with: complexNum!)
            actionLabel.alpha = 1
            actionLabel.text = actionButtons[1].titleLabel?.text
            self.view.endEditing(true)
            
        case 2:
            guard let complexNumber = calculator.makeMultiplication(
                    firstRealNum: firstNumTextFields[0],
                    firstImaginaryNum: firstNumTextFields[1],
                    firstModuleNum: firstNumTextFields[2],
                    firstArgumentNum: firstNumTextFields[3],
                    secondRealNum: secondNumTextFields[0],
                    secondImaginaryNum: secondNumTextFields[1],
                    secondModuleNum: secondNumTextFields[2],
                    secondArgumentNum: secondNumTextFields[3],
                    wrongFormatAlert: {
                        self.view.endEditing(true)
                        wrongFormatAlert()
                    }) else { return }
            complexNum = complexNumber
            
            showResult(with: complexNum!)
            actionLabel.alpha = 1
            actionLabel.text = actionButtons[2].titleLabel?.text
            self.view.endEditing(true)
            
        case 3:
            guard let complexNumber = calculator.makeDivision(
                    firstRealNum: firstNumTextFields[0],
                    firstImaginaryNum: firstNumTextFields[1],
                    firstModuleNum: firstNumTextFields[2],
                    firstArgumentNum: firstNumTextFields[3],
                    secondRealNum: secondNumTextFields[0],
                    secondImaginaryNum: secondNumTextFields[1],
                    secondModuleNum: secondNumTextFields[2],
                    secondArgumentNum: secondNumTextFields[3],
                    wrongFormatAlert: {
                        self.view.endEditing(true)
                        wrongFormatAlert()
                    }) else { return }
            complexNum = complexNumber
            
            showResult(with: complexNum!)
            actionLabel.alpha = 1
            actionLabel.text = actionButtons[3].titleLabel?.text
            self.view.endEditing(true)
            
        default:
            break
        }
    }
    
    @IBAction func clearButtonPressed() {
        for text in firstNumTextFields{
            text.text = nil
        }
        
        for text in secondNumTextFields{
            text.text = nil
        }
        
        setupTextViews()
        actionLabel.text = "+ - \u{00D7} \u{00F7}"
        actionLabel.alpha = 0.22
        self.view.endEditing(true)
        complexNum = nil
    }
    
    @IBAction func copyButtonPressed() {
        guard let complexNum = complexNum else { return }
        generalNum = complexNum.gneralForm
        expNum = complexNum.expForm
        
        clearPasteIndincator = false
        for button in pasteButtons {
            button.backgroundColor = #colorLiteral(red: 0.8122589588, green: 0.6094391346, blue: 1, alpha: 1)
            button.setTitle("paste", for: .normal)
        }
        
    }
    
    @IBAction func pasteOrClearButtonPressed(_ sender: UIButton) {
        if clearPasteIndincator == false {
            guard let generalNum = generalNum else { return }
            guard let expNum = expNum else { return }
            switch sender.tag {
            case 0:
                firstNumTextFields[0].text = String(format: "%.\(roundingValue)f", generalNum.realNum)
                firstNumTextFields[1].text = String(format: "%.\(roundingValue)f", generalNum.imaginaryNum)
                firstNumTextFields[2].text = String(format: "%.\(roundingValue)f", expNum.module)
                firstNumTextFields[3].text = String(format: "%.\(roundingValue)f", expNum.argument)
            case 1:
                secondNumTextFields[0].text = String(format: "%.\(roundingValue)f", generalNum.realNum)
                secondNumTextFields[1].text = String(format: "%.\(roundingValue)f", generalNum.imaginaryNum)
                secondNumTextFields[2].text = String(format: "%.\(roundingValue)f", expNum.module)
                secondNumTextFields[3].text = String(format: "%.\(roundingValue)f", expNum.argument)
            default:
                break
            }
            clearPasteIndincator = true
            for button in pasteButtons {
                button.backgroundColor = .lightGray
                button.setTitle("clear", for: .normal)
            }
        } else {
            switch sender.tag {
            case 0:
                firstNumTextFields[0].text = nil
                firstNumTextFields[1].text = nil
                firstNumTextFields[2].text = nil
                firstNumTextFields[3].text = nil
                self.view.endEditing(true)
            case 1:
                secondNumTextFields[0].text = nil
                secondNumTextFields[1].text = nil
                secondNumTextFields[2].text = nil
                secondNumTextFields[3].text = nil
                self.view.endEditing(true)
            default:
                break
            }
        }
    }
}


//MARK: - UITextFieldDelegate

extension CalculatorViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        addButtonsTo(textField)
        // For first number
        if textField == firstNumTextFields[0] || textField == firstNumTextFields[1] {
            if firstNumTextFields[2].text?.isEmpty == false {
                return false
            }
            if firstNumTextFields[3].text?.isEmpty == false {
                return false
            }
        }
        
        if textField == firstNumTextFields[2] || textField == firstNumTextFields[3] {
            if firstNumTextFields[0].text?.isEmpty == false {
                return false
            }
            if firstNumTextFields[1].text?.isEmpty == false {
                return false
            }
        }
        // For second number
        if textField == secondNumTextFields[0] || textField == secondNumTextFields[1] {
            if secondNumTextFields[2].text?.isEmpty == false {
                return false
            }
            if secondNumTextFields[3].text?.isEmpty == false {
                return false
            }
        }
        
        if textField == secondNumTextFields[2] || textField == secondNumTextFields[3] {
            if secondNumTextFields[0].text?.isEmpty == false {
                return false
            }
            if secondNumTextFields[1].text?.isEmpty == false {
                return false
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // For first number
        if textField == firstNumTextFields[0] {
            textField.resignFirstResponder()
            firstNumTextFields[1].becomeFirstResponder()
        }
        if textField == firstNumTextFields[1] {
            textField.resignFirstResponder()
        }
        
        if textField == firstNumTextFields[2] {
            textField.resignFirstResponder()
            firstNumTextFields[3].becomeFirstResponder()
        }
        if textField == firstNumTextFields[3] {
            textField.resignFirstResponder()
        }
        
        // For second number
        if textField == secondNumTextFields[0] {
            textField.resignFirstResponder()
            secondNumTextFields[1].becomeFirstResponder()
        }
        if textField == secondNumTextFields[1] {
            textField.resignFirstResponder()
        }
        
        if textField == secondNumTextFields[2] {
            textField.resignFirstResponder()
            secondNumTextFields[3].becomeFirstResponder()
        }
        if textField == secondNumTextFields[3] {
            textField.resignFirstResponder()
        }
        return true
    }
    
}

extension CalculatorViewController {
    
    private  func wrongFormatAlert() {
        
        let alert = UIAlertController(title: "Wrong format",
                                      message: "Please enter the number",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

//MARK: - UITextFieldDelegate and UIToolBar
extension CalculatorViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView == resultTextViews[0]{
            wrongFormatAlert()
        }
        return true
    }
    private func addButtonsTo(_ textField: UITextField) {
        
        let keyboardToolbar = UIToolbar()
        textField.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title:"Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapDone))
        
        let minusButton = UIBarButtonItem(title: "\u{2014}",
                                          style: .plain,
                                          target: self,
                                          action: #selector(addMinusTo))
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        
        keyboardToolbar.items = [ flexBarButton, minusButton, doneButton]
        
    }
    
    @objc private func didTapDone() {
        
        if firstNumTextFields[0].isEditing == true  {
            firstNumTextFields[0].resignFirstResponder()
            firstNumTextFields[1].becomeFirstResponder()
        } else if firstNumTextFields[1].isEditing == true {
            view.endEditing(true)
        } else if firstNumTextFields[2].isEditing == true  {
            firstNumTextFields[2].resignFirstResponder()
            firstNumTextFields[3].becomeFirstResponder()
        }else if firstNumTextFields[3].isEditing == true {
            view.endEditing(true)
        } else if secondNumTextFields[0].isEditing == true  {
            secondNumTextFields[0].resignFirstResponder()
            secondNumTextFields[1].becomeFirstResponder()
        } else if secondNumTextFields[1].isEditing == true {
            view.endEditing(true)
        } else if secondNumTextFields[2].isEditing == true  {
            secondNumTextFields[2].resignFirstResponder()
            secondNumTextFields[3].becomeFirstResponder()
        }else if secondNumTextFields[3].isEditing == true {
            view.endEditing(true)
        }
        
    }
    
    @objc private func addMinusTo() {
        
        if firstNumTextFields[0].isEditing == true && firstNumTextFields[0].text?.isEmpty == true {
            firstNumTextFields[0].text = "-"
        } else if firstNumTextFields[1].isEditing == true && firstNumTextFields[1].text?.isEmpty == true {
            firstNumTextFields[1].text = "-"
        } else if firstNumTextFields[2].isEditing == true && firstNumTextFields[2].text?.isEmpty == true {
            firstNumTextFields[2].text = "-"
        }else if firstNumTextFields[3].isEditing == true && firstNumTextFields[3].text?.isEmpty == true {
            firstNumTextFields[3].text = "-"
        } else  if secondNumTextFields[0].isEditing == true && secondNumTextFields[0].text?.isEmpty == true {
            secondNumTextFields[0].text = "-"
        } else if secondNumTextFields[1].isEditing == true && secondNumTextFields[1].text?.isEmpty == true {
            secondNumTextFields[1].text = "-"
        } else if secondNumTextFields[2].isEditing == true && secondNumTextFields[2].text?.isEmpty == true {
            secondNumTextFields[2].text = "-"
        }else if secondNumTextFields[3].isEditing == true && secondNumTextFields[3].text?.isEmpty == true {
            secondNumTextFields[3].text = "-"
        }
    }
    
}
