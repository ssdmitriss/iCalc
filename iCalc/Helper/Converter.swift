//
//  Helper.swift
//  Complex Calc
//
//  Created by Дмитрий Селезнев on 04.06.2020.
//  Copyright © 2020 Дмитрий Селезнев. All rights reserved.
//

import UIKit

class Converter  {
    static let shared = Converter()
    
    func convertToExpForm(realNum: Double, imaginaryNum: Double) -> ExpComplexNum {
        let module = Double(String(format: "%.\(roundingValue)f", sqrt(pow(realNum, 2) + pow(imaginaryNum, 2))))!
        var argument: Double {
            if (realNum >= 0 && imaginaryNum >= 0) || (realNum >= 0 && imaginaryNum < 0) {
                return Double(String(format: "%.\(roundingValue)f", atan(imaginaryNum / realNum ) * 180 / Double.pi))!
            } else if (realNum < 0 && imaginaryNum < 0) {
                return Double(String(format: "%.\(roundingValue)f", atan(imaginaryNum / realNum ) * 180 / Double.pi - 180))!
            } else {
                return Double(String(format: "%.\(roundingValue)f", 180 + atan(imaginaryNum / realNum ) * 180 / Double.pi))!
            }
        }
        let exponentialComplexNum = ExpComplexNum(module: module, argument: argument)
        return exponentialComplexNum
    }
    
    func convertToGeneral(module: Double, argument: Double) -> GeneralComplexNum {
        let realNum = Double(String(format: "%.\(roundingValue)f", module * cos(argument * Double.pi / 180)))!
        let imaginary = Double(String(format: "%.\(roundingValue)f", module * sin(argument * Double.pi / 180)))!
        let generalComplexNum = GeneralComplexNum(realNum: realNum, imaginaryNum: imaginary)
        return generalComplexNum
    }
    
    
    func textFieldsToExpForm(realTextField: UITextField,
                             imaginaryTextField: UITextField,
                             wrongFormatAlert: () -> Void) -> ExpComplexNum? {
        guard realTextField.text?.isEmpty == false || imaginaryTextField.text?.isEmpty == false else { return nil }
        guard let realText = realTextField.text else { return nil }
        guard let imaginaryText = imaginaryTextField.text else { return nil }
        
        guard let realNum = Double(realText) else {
            realTextField.becomeFirstResponder()
            wrongFormatAlert()
            return nil
        }
        guard let imaginaryNum = Double(imaginaryText) else {
            imaginaryTextField.becomeFirstResponder()
            wrongFormatAlert()
            return nil
        }
        return convertToExpForm(realNum: realNum, imaginaryNum: imaginaryNum)
    }
    
    func textFieldsToGeneralForm(moduleTextField: UITextField,
                             argumentTextField: UITextField,
                             wrongFormatAlert: () -> Void) -> GeneralComplexNum? {
        guard moduleTextField.text?.isEmpty == false || argumentTextField.text?.isEmpty == false else { return nil }
            guard let moduleText = moduleTextField.text else { return nil}
            guard let argumentText = argumentTextField.text else { return nil }
            
            guard let moduleNum = Double(moduleText) else {
                moduleTextField.becomeFirstResponder()
                wrongFormatAlert()
                return nil }
            guard let argumentNum = Double(argumentText) else {
                argumentTextField.becomeFirstResponder()
                wrongFormatAlert()
                return nil
            }
        return convertToGeneral(module: moduleNum, argument: argumentNum)
    }
}
