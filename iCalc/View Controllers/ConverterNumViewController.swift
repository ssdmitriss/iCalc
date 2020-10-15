//
//  ViewController.swift
//  Complex Calc
//
//  Created by Дмитрий Селезнев on 24.05.2020.
//  Copyright © 2020 Дмитрий Селезнев. All rights reserved.
//

import UIKit

class ConverterNumViewController: UIViewController {
    
    @IBOutlet weak var realTextField: UITextField!
    @IBOutlet weak var imaginaryTextField: UITextField!
    @IBOutlet weak var exponentialTextView: UITextView!
    
    @IBOutlet var convertButtons: [UIButton]!
    @IBOutlet var clearButtons: [UIButton]!
    
    @IBOutlet weak var moduleTextField: UITextField!
    @IBOutlet weak var argumentTextField: UITextField!
    @IBOutlet weak var generalTextView: UITextView!
    
    @IBOutlet weak var angleLabel: UILabel!
    
    let converter = Converter.shared
    let coreData = CoreDataMethods.shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        coreData.fetchReqest()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
        setupTextViews()
        angleLabel.text = "\u{2220}"
        argumentTextField.placeholder = "\u{03C6}\u{00B0}"
    }
    
    private func setupButtons() {
        for button in convertButtons {
            button.layer.cornerRadius = button.frame.height / 4
        }
        
        for button in clearButtons {
            button.layer.cornerRadius = button.frame.height / 4
            button.backgroundColor = .lightGray
        }
    }
    
    private func setupTextViews() {
        exponentialTextView.layer.cornerRadius = exponentialTextView.frame.height / 4
        exponentialTextView.text = "A \u{2220} \u{03C6}\u{00B0}"
        exponentialTextView.textColor = .opaqueSeparator
        
        generalTextView.layer.cornerRadius = generalTextView.frame.height / 4
        generalTextView.text = "a + i\u{00B7}b"
        generalTextView.textColor = .opaqueSeparator
        
//        generalTextView.textContainer.maximumNumberOfLines = 2
//        generalTextView.textContainer.lineBreakMode = .byWordWrapping
        
    }
    
    @IBAction func convertButtonPressed(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            guard let exponentialNum = converter.textFieldsToExpForm(
                    realTextField: realTextField,
                    imaginaryTextField: imaginaryTextField,
                    wrongFormatAlert: wrongFormatAlert
            ) else { return }
            exponentialTextView.textColor = .black
            exponentialTextView.text = "\(exponentialNum.module) \u{2220} \(exponentialNum.argument)"
            view.endEditing(true)
            
        case 1:
            guard let generalNum = converter.textFieldsToGeneralForm(
                    moduleTextField: moduleTextField,
                    argumentTextField: argumentTextField,
                    wrongFormatAlert: wrongFormatAlert
            ) else { return }
            generalTextView.textColor = .black
            if generalNum.imaginaryNum >= 0 {
                generalTextView.text = "\(generalNum.realNum) + i\u{00B7}\(generalNum.imaginaryNum)"
            } else {
                generalTextView.text = "\(generalNum.realNum) - i\u{00B7}\(generalNum.imaginaryNum * (-1))"
            }
            view.endEditing(true)
        default:
            break
        }
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            realTextField.text = nil
            imaginaryTextField.text = nil
            exponentialTextView.text = "A \u{2220} \u{03C6}\u{00B0}"
            exponentialTextView.textColor = .opaqueSeparator
        case 1:
            moduleTextField.text = nil
            argumentTextField.text = nil
            generalTextView.textColor = .opaqueSeparator
            generalTextView.text = "a + i\u{00B7}b"
        default:
            break
        }
    }
    
}

//MARK: - UITextFieldDelegate and UIToolBar
extension ConverterNumViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
 
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        addButtonsTo(textField)
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
        
        if realTextField.isEditing == true  {
            realTextField.resignFirstResponder()
            imaginaryTextField.becomeFirstResponder()
        } else if imaginaryTextField.isEditing == true {
            convertButtonPressed(convertButtons[0])
            view.endEditing(true)
        } else if moduleTextField.isEditing == true  {
            moduleTextField.resignFirstResponder()
            argumentTextField.becomeFirstResponder()
        }else if argumentTextField.isEditing == true {
            convertButtonPressed(convertButtons[1])
            view.endEditing(true)
        }
        
    }
    
    @objc private func addMinusTo() {
        
        if realTextField.isEditing == true && realTextField.text?.isEmpty == true {
            realTextField.text = "-"
        } else if imaginaryTextField.isEditing == true && imaginaryTextField.text?.isEmpty == true {
            imaginaryTextField.text = "-"
        } else if moduleTextField.isEditing == true && moduleTextField.text?.isEmpty == true {
            moduleTextField.text = "-"
        }else if argumentTextField.isEditing == true && argumentTextField.text?.isEmpty == true {
            argumentTextField.text = "-"
        }
    }

}

//MARK: - UIALertControllrel
extension ConverterNumViewController {
    
    private  func wrongFormatAlert() {
        
        let alert = UIAlertController(title: "Wrong format",
                                      message: "Please enter the number",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
