
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
    
    var openURlTimer: Timer?
    
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
        
        linkTextField.delegate = self
        linkTextField.addTarget(self, action: #selector(urlTextChanged), for: .editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        onlyLettersTextField.becomeFirstResponder()
    }
    
    
    @objc
    func urlTextChanged() {
        let pattern = "(?i)https?:\\/\\/(?:www\\.)?\\S+(?:\\/|\\b)"

        guard let text = linkTextField.text,
              text.range(of: pattern, options: .regularExpression) != nil,
              let url = URL(string: text) else { return  }
        openURlTimer?.invalidate()
        openURlTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { timer in
            UIApplication.shared.open(url, options: [:]) { (done) in
                print("Link was open successfully")
            }
        })

    }
    //MARK: TF1, no digits & TF3 only letters\dash\only numbers
    
    var onlyNums = false
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string != "" else { return true} // if backspace return true

        switch textField {
        case letterDashNumberField:
            return shoudAddCharecterToDashField(string: string,
                                                previousText: letterDashNumberField.text)
        case onlyLettersTextField:
            return onlyLetters(string: string)
        default:
            break
        }
        return true
    }
    func shoudAddCharecterToDashField(string: String, previousText: String?) -> Bool {
        let containsDash = previousText?.contains("-") ?? false
        if let previousText = previousText { //already have text
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
    func onlyNumbers(string: String) -> Bool {
        if string == "-" {
            return true
        }
        return !onlyLetters(string: string)
    }
    
    func onlyLetters(string: String) -> Bool {
        guard string != "" else { return true }
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
