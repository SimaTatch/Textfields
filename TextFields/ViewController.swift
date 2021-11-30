
import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var inputLimitField: UITextField!
    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var minLengthLabel: UILabel!
    
    @IBOutlet weak var minOneDigitLabel: UILabel!
    @IBOutlet weak var minOneLowercaseLabel: UILabel!
    @IBOutlet weak var minOneCapitalLabel: UILabel!
    
    
    @IBOutlet weak var onlyLettersTextField: UITextField!
    @IBOutlet weak var letterDashNumberField: UITextField!
    
    
    public let allowedChars = 10
    let inputLimit = InputLimit()
    let onlyLetters = OnlyLettersAndOnlyNums()
    
    var openURlTimer: Timer?
    
    private let minLength = 8
    private lazy var regex = "^(?=.*[а-я])(?=.*[А-Я])(?=.*\\d)[А-Яа-я\\dd$@$!%*?&#]{\(minLength),}$"
    private lazy var regexOneCapitalLetter = "^(?=.*[А-Я]){\(1),}$"
    private lazy var regexOneLowercaseLetter = "^(?=.*[а-я]){\(1),}$"
    private lazy var regexOneDigit = "^(?=.*\\d){\(1),}$"
    
    
    
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
        self.linkTextField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        linkTextField.delegate = self
        //        5
        passwordTextField.delegate = self
        
    }
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        onlyLettersTextField.becomeFirstResponder()
    //    }
    
    func textField1(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string != "" else {return true} // if backspace return true
        switch textField {
            //            MARK: TF1, no digits
        case onlyLettersTextField:
            return onlyLetters.onlyLetters(string: string)
            //           MARK: TF3 only letters\dash\only numbers
        case letterDashNumberField:
            return onlyLetters.shoudAddCharecterToDashField(string: string,
                                                            previousText: letterDashNumberField.text)
        default:
            break
        }
        return true
    }
    
    //            MARK: TF2, characters limit
    func textFieldDidChangeSelection(_ textField: UITextField) {
        inputLimit.checkRemainingChars(inputLimitField, characterCountLabel)
    }
    
    //    MARK: LINK done
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if openURlTimer != nil {
            openURlTimer?.invalidate()
            openURlTimer = nil
        }
        openURlTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(searchForResult (_:)), userInfo: linkTextField.text!, repeats: false)
    }
    
    @objc func searchForResult (_ timer: Timer) {
        let pattern = "(?i)https?:\\/\\/(?:www\\.)?\\S+(?:\\/|\\b)"
        guard let text = linkTextField.text,
              text.range(of: pattern, options: .regularExpression) != nil,
              let url = URL(string: text) else { return print("что-то не так")}
        UIApplication.shared.open(url, options: [:]) { (done) in
            print("Link was open successfully")
        }
    }
    
    // MARK: password validation rules
    
    private func checkValidation (password: String) {
        guard password.count >= minLength else {
            minLengthLabel.text = "- Min length 8 characters."
            return
        }
        
        if password.matches(regex) {
            minLengthLabel.textColor = .green
            minLengthLabel.text = "\u{2713}" + "Min length 8 characters,"
        } else if password.matches(regexOneDigit) {
            minOneDigitLabel.textColor = .green
            minOneDigitLabel.text = "\u{2713}" + "Min 1 digit,"
        } else if password.matches(regexOneLowercaseLetter) {
            minOneLowercaseLabel.textColor = .green
            minOneLowercaseLabel.text = "\u{2713}" + "Min 1 lowercase,"
        } else if password.matches(regexOneCapitalLetter) {
            minOneCapitalLabel.textColor = .green
            minOneCapitalLabel.text = "\u{2713}" + "Min 1 capital required."
        }
    }
}

extension ViewController: UITextViewDelegate {
    func textField (_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") + string
        let res: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            res = String(text[text.startIndex..<end])
        } else {
            res = text
        }
        checkValidation(password: res)
        textField.text = res
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
