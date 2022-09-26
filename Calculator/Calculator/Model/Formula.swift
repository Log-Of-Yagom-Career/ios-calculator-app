//
//  Formula.swift
//  Calculator
//
//  Created by Baem on 2022/09/24.
//

struct Formula {
    var operands: CalculatorItemQueue
    var operators: CalculatorItemQueue
    
    mutating func result() throws -> Double {
        var calculateResult = operands.dequeue()
        guard operators.count != (operands.count) else {
            return 1.1
//            throw FormulaError.notValidCountQueue
        }
        
        while !operators.isEmpty {
            guard let operators = operators.dequeue() as? Operator else {
                throw FormulaError.notOperator
            }
            
            calculateResult = operators.calculates (
                lhs: calculateResult as! Double,
                rhs: operands.dequeue() as! Double
            )
        }
            
        return calculateResult as! Double
    }
}
