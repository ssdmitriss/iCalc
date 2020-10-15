//
//  Calculator.swift
//  Complex Calc
//
//  Created by Дмитрий Селезнев on 11.06.2020.
//  Copyright © 2020 Дмитрий Селезнев. All rights reserved.
//

import UIKit

class Calculator {
    static let shared = Calculator()
    private let converter = Converter.shared
    
    func makeAddition(firstRealNum: UITextField,
                      firstImaginaryNum: UITextField,
                      firstModuleNum: UITextField,
                      firstArgumentNum: UITextField,
                      secondRealNum: UITextField,
                      secondImaginaryNum: UITextField,
                      secondModuleNum: UITextField,
                      secondArgumentNum: UITextField,
                      wrongFormatAlert: () -> Void) -> ComplexNum? {
        if firstRealNum.text?.isEmpty == false && secondRealNum.text?.isEmpty == false {
            guard let complexNumber = additionGeneral(
                firstNumOne: firstRealNum,
                firstNumTwo: firstImaginaryNum,
                firstGenFormIndicator: true,
                secondNumOne: secondRealNum,
                secondNumTwo: secondImaginaryNum,
                secondGenFormIndicator: true
            ) else {
                wrongFormatAlert()
                return nil
            }
            return complexNumber
        } else if firstRealNum.text?.isEmpty == false && secondRealNum.text?.isEmpty == true {
            guard let complexNumber = additionGeneral(
                firstNumOne: firstRealNum,
                firstNumTwo: firstImaginaryNum,
                firstGenFormIndicator: true,
                secondNumOne: secondModuleNum,
                secondNumTwo: secondArgumentNum,
                secondGenFormIndicator: false
            ) else {
                wrongFormatAlert()
                return nil
            }
            return complexNumber
        } else if firstRealNum.text?.isEmpty == true && secondRealNum.text?.isEmpty == false {
            guard let complexNumber = additionGeneral(
                firstNumOne: firstModuleNum,
                firstNumTwo: firstArgumentNum,
                firstGenFormIndicator: false,
                secondNumOne: secondRealNum,
                secondNumTwo: secondImaginaryNum,
                secondGenFormIndicator: true
            ) else {
                wrongFormatAlert()
                return nil
            }
            return complexNumber
        } else if firstRealNum.text?.isEmpty == true && secondRealNum.text?.isEmpty == true {
            guard let complexNumber = additionGeneral(
                firstNumOne: firstModuleNum,
                firstNumTwo: firstArgumentNum,
                firstGenFormIndicator: false,
                secondNumOne: secondModuleNum,
                secondNumTwo: secondArgumentNum,
                secondGenFormIndicator: false
            ) else {
                wrongFormatAlert()
                return nil
            }
            return complexNumber
        }
        return nil
    }
    
    func makeSubtraction(firstRealNum: UITextField,
                         firstImaginaryNum: UITextField,
                         firstModuleNum: UITextField,
                         firstArgumentNum: UITextField,
                         secondRealNum: UITextField,
                         secondImaginaryNum: UITextField,
                         secondModuleNum: UITextField,
                         secondArgumentNum: UITextField,
                         wrongFormatAlert: () -> Void) -> ComplexNum?{
        if firstRealNum.text?.isEmpty == false && secondRealNum.text?.isEmpty == false {
            guard let complexNumber = subtractionGeneral(
                firstNumOne: firstRealNum,
                firstNumTwo: firstImaginaryNum,
                firstGenFormIndicator: true,
                secondNumOne: secondRealNum,
                secondNumTwo: secondImaginaryNum,
                secondGenFormIndicator: true
            ) else {
                wrongFormatAlert()
                return nil
            }
            return complexNumber
        } else if firstRealNum.text?.isEmpty == false && secondRealNum.text?.isEmpty == true {
            guard let complexNumber = subtractionGeneral(
                firstNumOne: firstRealNum,
                firstNumTwo: firstImaginaryNum,
                firstGenFormIndicator: true,
                secondNumOne: secondModuleNum,
                secondNumTwo: secondArgumentNum,
                secondGenFormIndicator: false
            ) else {
                wrongFormatAlert()
                return nil
            }
            return complexNumber
        } else if firstRealNum.text?.isEmpty == true && secondRealNum.text?.isEmpty == false {
            guard let complexNumber = subtractionGeneral(
                firstNumOne: firstModuleNum,
                firstNumTwo: firstArgumentNum,
                firstGenFormIndicator: false,
                secondNumOne: secondRealNum,
                secondNumTwo: secondImaginaryNum,
                secondGenFormIndicator: true
            ) else {
                wrongFormatAlert()
                return nil
            }
            return complexNumber
        } else if firstRealNum.text?.isEmpty == true && secondRealNum.text?.isEmpty == true {
            guard let complexNumber = subtractionGeneral(
                firstNumOne: firstModuleNum,
                firstNumTwo: firstArgumentNum,
                firstGenFormIndicator: false,
                secondNumOne: secondModuleNum,
                secondNumTwo: secondArgumentNum,
                secondGenFormIndicator: false
            ) else {
                wrongFormatAlert()
                return nil
            }
            return complexNumber
        }
        return nil
    }
    
    func makeMultiplication(firstRealNum: UITextField,
                            firstImaginaryNum: UITextField,
                            firstModuleNum: UITextField,
                            firstArgumentNum: UITextField,
                            secondRealNum: UITextField,
                            secondImaginaryNum: UITextField,
                            secondModuleNum: UITextField,
                            secondArgumentNum: UITextField,
                            wrongFormatAlert: () -> Void) -> ComplexNum?{
        if firstRealNum.text?.isEmpty == false && secondRealNum.text?.isEmpty == false {
            guard let complexNumber = multiplicationGeneral(
                firstNumOne: firstRealNum,
                firstNumTwo: firstImaginaryNum,
                firstGenFormIndicator: true,
                secondNumOne: secondRealNum,
                secondNumTwo: secondImaginaryNum,
                secondGenFormIndicator: true
            ) else {
                wrongFormatAlert()
                return nil
            }
            return complexNumber
        } else if firstRealNum.text?.isEmpty == false && secondRealNum.text?.isEmpty == true {
            guard let complexNumber = multiplicationGeneral(
                firstNumOne: firstRealNum,
                firstNumTwo: firstImaginaryNum,
                firstGenFormIndicator: true,
                secondNumOne: secondModuleNum,
                secondNumTwo: secondArgumentNum,
                secondGenFormIndicator: false
            ) else {
                wrongFormatAlert()
                return nil
            }
            return complexNumber
        } else if firstRealNum.text?.isEmpty == true && secondRealNum.text?.isEmpty == false {
            guard let complexNumber = multiplicationGeneral(
                firstNumOne: firstModuleNum,
                firstNumTwo: firstArgumentNum,
                firstGenFormIndicator: false,
                secondNumOne: secondRealNum,
                secondNumTwo: secondImaginaryNum,
                secondGenFormIndicator: true
            ) else {
                wrongFormatAlert()
                return nil
            }
            return complexNumber
        } else if firstRealNum.text?.isEmpty == true && secondRealNum.text?.isEmpty == true {
            guard let complexNumber = multiplicationGeneral(
                firstNumOne: firstModuleNum,
                firstNumTwo: firstArgumentNum,
                firstGenFormIndicator: false,
                secondNumOne: secondModuleNum,
                secondNumTwo: secondArgumentNum,
                secondGenFormIndicator: false
            ) else {
                wrongFormatAlert()
                return nil
            }
            return complexNumber
        }
        return nil
    }
    
    func makeDivision(firstRealNum: UITextField,
                      firstImaginaryNum: UITextField,
                      firstModuleNum: UITextField,
                      firstArgumentNum: UITextField,
                      secondRealNum: UITextField,
                      secondImaginaryNum: UITextField,
                      secondModuleNum: UITextField,
                      secondArgumentNum: UITextField,
                      wrongFormatAlert: () -> Void) -> ComplexNum?{
        if firstRealNum.text?.isEmpty == false && secondRealNum.text?.isEmpty == false {
            guard let complexNumber = divisionGeneral(
                firstNumOne: firstRealNum,
                firstNumTwo: firstImaginaryNum,
                firstGenFormIndicator: true,
                secondNumOne: secondRealNum,
                secondNumTwo: secondImaginaryNum,
                secondGenFormIndicator: true
            ) else {
                wrongFormatAlert()
                return nil
            }
            return complexNumber
        } else if firstRealNum.text?.isEmpty == false && secondRealNum.text?.isEmpty == true {
            guard let complexNumber = divisionGeneral(
                firstNumOne: firstRealNum,
                firstNumTwo: firstImaginaryNum,
                firstGenFormIndicator: true,
                secondNumOne: secondModuleNum,
                secondNumTwo: secondArgumentNum,
                secondGenFormIndicator: false
            ) else {
                wrongFormatAlert()
                return nil
            }
            return complexNumber
        } else if firstRealNum.text?.isEmpty == true && secondRealNum.text?.isEmpty == false {
            guard let complexNumber = divisionGeneral(
                firstNumOne: firstModuleNum,
                firstNumTwo: firstArgumentNum,
                firstGenFormIndicator: false,
                secondNumOne: secondRealNum,
                secondNumTwo: secondImaginaryNum,
                secondGenFormIndicator: true
            ) else {
                wrongFormatAlert()
                return nil
            }
            return complexNumber
        } else if firstRealNum.text?.isEmpty == true && secondRealNum.text?.isEmpty == true {
            guard let complexNumber = divisionGeneral(
                firstNumOne: firstModuleNum,
                firstNumTwo: firstArgumentNum,
                firstGenFormIndicator: false,
                secondNumOne: secondModuleNum,
                secondNumTwo: secondArgumentNum,
                secondGenFormIndicator: false
            ) else {
                wrongFormatAlert()
                return nil
            }
            return complexNumber
        }
        return nil
    }
    
    private func addition(firstNum: GeneralComplexNum, secondNum: GeneralComplexNum) -> GeneralComplexNum {
        let real = firstNum.realNum + secondNum.realNum
        let imaginary = firstNum.imaginaryNum + secondNum.imaginaryNum
        return GeneralComplexNum(realNum: real, imaginaryNum: imaginary)
    }
    
    private func subtraction(firstNum: GeneralComplexNum, secondNum: GeneralComplexNum) -> GeneralComplexNum {
        let real = firstNum.realNum - secondNum.realNum
        let imaginary = firstNum.imaginaryNum - secondNum.imaginaryNum
        return GeneralComplexNum(realNum: real, imaginaryNum: imaginary)
    }
    
    private func multiplication(firstNum: ExpComplexNum, secondNum: ExpComplexNum) -> ExpComplexNum {
        let module = firstNum.module * secondNum.module
        let argument = firstNum.argument + secondNum.argument
        return ExpComplexNum(module: module, argument: argument)
    }
    private func division(firstNum: ExpComplexNum, secondNum: ExpComplexNum) -> ExpComplexNum {
        let module = firstNum.module / secondNum.module
        let argument = firstNum.argument - secondNum.argument
        return ExpComplexNum(module: module, argument: argument)
    }
    
    
    private func additionGeneral(firstNumOne: UITextField,
                                 firstNumTwo: UITextField,
                                 firstGenFormIndicator: Bool,
                                 secondNumOne: UITextField,
                                 secondNumTwo: UITextField,
                                 secondGenFormIndicator: Bool) -> ComplexNum? {
        
        var firstNum: GeneralComplexNum
        var secondNum: GeneralComplexNum
        var complexNum: ComplexNum
        
        if firstGenFormIndicator == true {
            guard let realText = firstNumOne.text else { return nil }
            guard let imaginaryText = firstNumTwo.text else { return nil }
            guard let realNum = Double(realText) else { return nil}
            guard  let imaginaryNum = Double(imaginaryText) else { return nil }
            firstNum = GeneralComplexNum(realNum: realNum, imaginaryNum: imaginaryNum)
        } else {
            guard let moduleText = firstNumOne.text else { return nil}
            guard let argumentText = firstNumTwo.text else { return nil}
            guard let moduleNum = Double(moduleText) else { return nil}
            guard  let argumentNum = Double(argumentText) else { return nil}
            firstNum = converter.convertToGeneral(module: moduleNum, argument: argumentNum)
        }
        
        if secondGenFormIndicator == true {
            guard let realText = secondNumOne.text else { return nil }
            guard let imaginaryText = secondNumTwo.text else { return nil}
            guard let realNum = Double(realText) else { return nil}
            guard  let imaginaryNum = Double(imaginaryText) else { return nil}
            secondNum = GeneralComplexNum(realNum: realNum, imaginaryNum: imaginaryNum)
        } else {
            guard let moduleText = secondNumOne.text else { return nil}
            guard let argumentText = secondNumTwo.text else { return nil}
            guard let moduleNum = Double(moduleText) else { return nil}
            guard  let argumentNum = Double(argumentText) else { return nil}
            secondNum = converter.convertToGeneral(module: moduleNum, argument: argumentNum)
        }
        
        let resultGeneral = addition(firstNum: firstNum, secondNum: secondNum)
        let resultExp = converter.convertToExpForm(realNum: resultGeneral.realNum, imaginaryNum: resultGeneral.imaginaryNum)
        complexNum = ComplexNum(gneralForm: resultGeneral, expForm: resultExp)
        return complexNum
        
    }
    
    private func subtractionGeneral(firstNumOne: UITextField,
                                    firstNumTwo: UITextField,
                                    firstGenFormIndicator: Bool,
                                    secondNumOne: UITextField,
                                    secondNumTwo: UITextField,
                                    secondGenFormIndicator: Bool) -> ComplexNum? {
        
        var firstNum: GeneralComplexNum
        var secondNum: GeneralComplexNum
        var complexNum: ComplexNum
        
        if firstGenFormIndicator == true {
            guard let realText = firstNumOne.text else { return nil }
            guard let imaginaryText = firstNumTwo.text else { return nil }
            guard let realNum = Double(realText) else { return nil}
            guard  let imaginaryNum = Double(imaginaryText) else { return nil }
            firstNum = GeneralComplexNum(realNum: realNum, imaginaryNum: imaginaryNum)
        } else {
            guard let moduleText = firstNumOne.text else { return nil}
            guard let argumentText = firstNumTwo.text else { return nil}
            guard let moduleNum = Double(moduleText) else { return nil}
            guard  let argumentNum = Double(argumentText) else { return nil}
            firstNum = converter.convertToGeneral(module: moduleNum, argument: argumentNum)
        }
        
        if secondGenFormIndicator == true {
            guard let realText = secondNumOne.text else { return nil }
            guard let imaginaryText = secondNumTwo.text else { return nil}
            guard let realNum = Double(realText) else { return nil}
            guard  let imaginaryNum = Double(imaginaryText) else { return nil}
            secondNum = GeneralComplexNum(realNum: realNum, imaginaryNum: imaginaryNum)
        } else {
            guard let moduleText = secondNumOne.text else { return nil}
            guard let argumentText = secondNumTwo.text else { return nil}
            guard let moduleNum = Double(moduleText) else { return nil}
            guard  let argumentNum = Double(argumentText) else { return nil}
            secondNum = converter.convertToGeneral(module: moduleNum, argument: argumentNum)
        }
        
        let resultGeneral = subtraction(firstNum: firstNum, secondNum: secondNum)
        let resultExp = converter.convertToExpForm(realNum: resultGeneral.realNum, imaginaryNum: resultGeneral.imaginaryNum)
        complexNum = ComplexNum(gneralForm: resultGeneral, expForm: resultExp)
        return complexNum
        
    }
    
    private func multiplicationGeneral(firstNumOne: UITextField,
                                       firstNumTwo: UITextField,
                                       firstGenFormIndicator: Bool,
                                       secondNumOne: UITextField,
                                       secondNumTwo: UITextField,
                                       secondGenFormIndicator: Bool) -> ComplexNum? {
        
        var firstNum: ExpComplexNum
        var secondNum: ExpComplexNum
        var complexNum: ComplexNum
        
        if firstGenFormIndicator == true {
            guard let realText = firstNumOne.text else { return nil }
            guard let imaginaryText = firstNumTwo.text else { return nil }
            guard let realNum = Double(realText) else { return nil}
            guard  let imaginaryNum = Double(imaginaryText) else { return nil }
            firstNum = converter.convertToExpForm(realNum: realNum, imaginaryNum: imaginaryNum)
        } else {
            guard let moduleText = firstNumOne.text else { return nil}
            guard let argumentText = firstNumTwo.text else { return nil}
            guard let moduleNum = Double(moduleText) else { return nil}
            guard  let argumentNum = Double(argumentText) else { return nil}
            firstNum = ExpComplexNum(module: moduleNum, argument: argumentNum)
        }
        
        if secondGenFormIndicator == true {
            guard let realText = secondNumOne.text else { return nil }
            guard let imaginaryText = secondNumTwo.text else { return nil}
            guard let realNum = Double(realText) else { return nil}
            guard  let imaginaryNum = Double(imaginaryText) else { return nil}
            secondNum = converter.convertToExpForm(realNum: realNum, imaginaryNum: imaginaryNum)
        } else {
            guard let moduleText = secondNumOne.text else { return nil}
            guard let argumentText = secondNumTwo.text else { return nil}
            guard let moduleNum = Double(moduleText) else { return nil}
            guard  let argumentNum = Double(argumentText) else { return nil}
            secondNum = ExpComplexNum(module: moduleNum, argument: argumentNum)
        }
        
        let resultExp = multiplication(firstNum: firstNum, secondNum: secondNum)
        let resultGeneral = converter.convertToGeneral(module: resultExp.module, argument: resultExp.argument)
        complexNum = ComplexNum(gneralForm: resultGeneral, expForm: resultExp)
        return complexNum
    }
    
    private func divisionGeneral(firstNumOne: UITextField,
                                 firstNumTwo: UITextField,
                                 firstGenFormIndicator: Bool,
                                 secondNumOne: UITextField,
                                 secondNumTwo: UITextField,
                                 secondGenFormIndicator: Bool) -> ComplexNum? {
        
        var firstNum: ExpComplexNum
        var secondNum: ExpComplexNum
        var complexNum: ComplexNum
        
        if firstGenFormIndicator == true {
            guard let realText = firstNumOne.text else { return nil }
            guard let imaginaryText = firstNumTwo.text else { return nil }
            guard let realNum = Double(realText) else { return nil}
            guard  let imaginaryNum = Double(imaginaryText) else { return nil }
            firstNum = converter.convertToExpForm(realNum: realNum, imaginaryNum: imaginaryNum)
        } else {
            guard let moduleText = firstNumOne.text else { return nil}
            guard let argumentText = firstNumTwo.text else { return nil}
            guard let moduleNum = Double(moduleText) else { return nil}
            guard  let argumentNum = Double(argumentText) else { return nil}
            firstNum = ExpComplexNum(module: moduleNum, argument: argumentNum)
        }
        
        if secondGenFormIndicator == true {
            guard let realText = secondNumOne.text else { return nil }
            guard let imaginaryText = secondNumTwo.text else { return nil}
            guard let realNum = Double(realText) else { return nil}
            guard  let imaginaryNum = Double(imaginaryText) else { return nil}
            secondNum = converter.convertToExpForm(realNum: realNum, imaginaryNum: imaginaryNum)
        } else {
            guard let moduleText = secondNumOne.text else { return nil}
            guard let argumentText = secondNumTwo.text else { return nil}
            guard let moduleNum = Double(moduleText) else { return nil}
            guard  let argumentNum = Double(argumentText) else { return nil}
            secondNum = ExpComplexNum(module: moduleNum, argument: argumentNum)
        }
        
        let resultExp = division(firstNum: firstNum, secondNum: secondNum)
        let resultGeneral = converter.convertToGeneral(module: resultExp.module, argument: resultExp.argument)
        complexNum = ComplexNum(gneralForm: resultGeneral, expForm: resultExp)
        return complexNum
    }
    
}

