//
//  ComplexNum.swift
//  Complex Calc
//
//  Created by Дмитрий Селезнев on 04.06.2020.
//  Copyright © 2020 Дмитрий Селезнев. All rights reserved.
//

import Foundation

struct ComplexNum {
    var gneralForm: GeneralComplexNum
    var expForm: ExpComplexNum
}

struct GeneralComplexNum {
    var realNum: Double = 0
    var imaginaryNum: Double = 0
}

struct ExpComplexNum {
    var module: Double = 0
    var argument: Double = 0
}
