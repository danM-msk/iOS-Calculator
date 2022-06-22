	//  Created by Daniyar Mamadov on 20.06.2022.

import UIKit

internal struct CalculatorLogic {
	
	private var number: Double?
	
	private var intermediateCalculation: (firstNumber: Double, operation: String)?
	
	internal mutating func setNumber(_ number: Double) {
		self.number = number
	}
	
	internal mutating func calculate(symbol:  String) -> Double? {
		
		if let n = number {
			switch symbol {
			case "AC", "C":
				return 0
			case "+/-":
				return n * -1
			case "%":
				return n * 0.01
			case "=":
				return performCalculation(secondNumber: n)
			default:
				intermediateCalculation = (firstNumber: n, operation: symbol)
			}
		}
		return nil
	}
	
	private func performCalculation(secondNumber: Double) -> Double? {
		if let firstNumber = intermediateCalculation?.firstNumber,
		   let operation = intermediateCalculation?.operation {
			switch operation {
			case "+":
				return firstNumber + secondNumber
			case "-":
				return firstNumber - secondNumber
			case "x":
				return firstNumber * secondNumber
			case "÷":
				return firstNumber - secondNumber
			default:
				fatalError("The operation passed in does not match any cases.")
			}
		} else {
			return nil
		}
	}
}
