
import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var inputLimitField: UITextField!
    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var minLengthLabel: UILabel!
    @IBOutlet weak var onlyLettersTextField: UITextField!
    @IBOutlet weak var letterDashNumberField: UITextField!
    
    
    private let allowedChars = 10
    private let minLength = 8
    private lazy var regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[A-Za-z\\dd$@$!%*?&#]{\(minLength),}"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        1
        onlyLettersTextField.delegate = self
        //        2
        characterCountLabel.text = "\(allowedChars)/\(allowedChars)"
        inputLimitField.delegate = self
        //        3
        letterDashNumberField.delegate = self
        //        4
        toOpenLink.addTarget(self, action: #selector(openLink), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        onlyLettersTextField.becomeFirstResponder()
    }
    
    //MARK: TF1, no digits & TF3 only letters\dash\only numbers
    
    var onlyNums = false
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case letterDashNumberField:
            if string == "-" && onlyNums == false {
                onlyNums = true
            } else if string == "-" && onlyNums == true {
                onlyNums = false
            }
            return onlyNums ? onlyNumbers(string: string) : onlyLetters(string: string)
        case onlyLettersTextField:
            return onlyLetters(string: string)
        default:
            break
        }
        return true
    }
    
    func onlyNumbers(string: String) -> Bool {
        if string == "-" {
            return true
        }
        return !onlyLetters(string: string)
    }
    
    func onlyLetters(string: String) -> Bool {
        let leftSideField = CharacterSet.decimalDigits
        let rightSideField = CharacterSet(charactersIn: string)
        return !leftSideField.isSuperset(of: rightSideField)
    }
    
    //MARK:  TF2, characters limit, done
    
    func checkRemainingChars() {
        let charsInTextView = -(inputLimitField.text?.count ?? 0)
        let remainingChars = allowedChars + charsInTextView
        characterCountLabel.textColor = .black
        inputLimitField.textColor = .black
        inputLimitField.layer.borderColor = UIColor.systemGray6.cgColor
        if remainingChars < 0 {
            inputLimitField.attributedText = getColoredText(text: inputLimitField.text!)
            characterCountLabel.textColor = .red
            inputLimitField.layer.borderColor = UIColor.red.cgColor
            inputLimitField.layer.cornerRadius = 6.0
            inputLimitField.layer.borderWidth = 1.0
        }
        characterCountLabel.text = ("\(String(remainingChars))/10")
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkRemainingChars()
    }
    func getColoredText(text:String) -> NSMutableAttributedString {
        let string:NSMutableAttributedString = NSMutableAttributedString(string: text)
        let range: NSRange = NSRange(location: 10, length: string.length - allowedChars)
        string.addAttribute(.foregroundColor, value: UIColor.red, range: range)
        return string
    }

//    MARK: LINK almost done

    @IBOutlet weak var toOpenLink: UIButton!
    @objc func openLink() {
        if let urlToOpen = URL(string: linkTextField.text!) {
            UIApplication.shared.open(urlToOpen, options: [:]) { (done) in
                print("Link was open successfully")
            }
        }
    }

// MARK: password validation rules
//    ✔
//    func isPasswordValidate(_ password : String)->Bool{
//        let validatePassword = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
//        return validatePassword.evaluate(with: password)
//    }
//
}
