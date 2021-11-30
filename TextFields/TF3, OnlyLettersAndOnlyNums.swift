
import Foundation
import UIKit

class OnlyLettersAndOnlyNums {
    
    func shoudAddCharecterToDashField(string: String, previousText: String?) -> Bool {
        let containsDash = previousText?.contains("-") ?? false
        if previousText != nil { //already have text
            if !containsDash && string == "-" {
                return true
            }
            if string.count == 1 { // entering throught keyboard
                if let inputCh = string.last {
                    return containsDash ? inputCh.isNumber : inputCh.isLetter
                }
            } else { // paste
                return true
            }
        } else {
            return string.last?.isLetter ?? false
        }
        return true
    }

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
