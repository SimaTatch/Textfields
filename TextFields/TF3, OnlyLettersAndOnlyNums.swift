
import Foundation
import UIKit

class OnlyLettersAndOnlyNums {
    
    func onlyLetters(string: String) -> Bool {
        let leftSideField = CharacterSet.decimalDigits
        let rightSideField = CharacterSet(charactersIn: string)
        return !leftSideField.isSuperset(of: rightSideField)
    }
    func onlyNumbers(string: String) -> Bool {
        if string == "-" {
            return true
        }
        return !OnlyLettersAndOnlyNums().onlyLetters(string: string)
    }
}
