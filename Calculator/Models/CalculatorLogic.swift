//  Created by Daniyar Mamadov on 20.06.2022.

import UIKit

final internal class CalculatorLogic {
    
    private var number: Double?
    
    init(number: Double) {
        self.number = number
    }
    
    internal func calculate(symbol:  String) -> Double? {
        switch symbol {
        case "AC", "C":
//            clear.setTitle("AC", for: .normal)
            return 0
        case "+/-":
            return number! * -1
        case "%":
            return number! * 0.01
//        case "+":
//            sender.backgroundColor = .white
//            sender.setTitleColor(UIColor(named: "Orange"), for: .normal)
        default:
            return nil
        }
    }
}
