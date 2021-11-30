import UIKit
import Foundation

class InputLimit {
    
    
    //    color in red extra letters
    func getColoredText(_ text: String) -> NSMutableAttributedString {
        let string:NSMutableAttributedString = NSMutableAttributedString(string: text)
        let range: NSRange = NSRange(location: ViewController().allowedChars, length: string.length - ViewController().allowedChars)
        string.addAttribute(.foregroundColor, value: UIColor.red, range: range)
        return string
    }
    
    
    func checkRemainingChars(_ textField: UITextField, _ label: UILabel) {
        let charsInTextView = -(textField.text?.count ?? 0)
        let remainingChars = ViewController().allowedChars + charsInTextView
        label.textColor = .black
        textField.textColor = .black
        textField.layer.borderColor = UIColor.systemGray6.cgColor
        if remainingChars < 0 {
            textField.attributedText = getColoredText(textField.text ?? "")
            label.textColor = .red
            textField.layer.borderColor = UIColor.red.cgColor
            textField.layer.cornerRadius = 6.0
            textField.layer.borderWidth = 1.0
        }
        label.text = ("\(String(remainingChars))/10")
    }
    

}
