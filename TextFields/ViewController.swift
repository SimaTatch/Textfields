
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
    public var openURlTimer: Timer?
    public let minLength = 8
    public lazy var regex =  "^[A-Za-z0-9 !\"#$%&'()*,./:;<=>?@\\[\\\\\\]^_`{|}~].{\(minLength),}$"
    public lazy var regexOneCapitalLetter = "^[A-Z]+$"
    public lazy var regexOneLowercaseLetter = "^[a-z]+$"
    public lazy var regexOneDigit = "^[0-9]+$"
    
    
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
        progressView.setProgress(0, animated: true)
        progressView.progressViewStyle = UIProgressView.Style.bar
        //        some keyboard features
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWilHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    

    
    @objc func keyboardWillShow (notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.letterDashNumberField.isFirstResponder {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height/3
                }
            } else if self.linkTextField.isFirstResponder || self.passwordTextField.isFirstResponder {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        }
    }
    
    
    
    @objc func keyboardWilHide (notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
            //            MARK: TF1, no digits
        case onlyLettersTextField:
            guard string != "" else {return true}
            return onlyLetters.onlyLetters(string: string)
            //           MARK: TF3 only letters\dash\only numbers
        case letterDashNumberField:
            guard string != "" else {return true}
            return onlyLetters.shoudAddCharecterToDashField(string: string,previousText: letterDashNumberField.text)
            //           MARK: TF5 passwordValidation
        case passwordTextField:

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
        default:
            break
        }
        return true
    }
    
    //            MARK: TF2, characters limit
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case inputLimitField:
            inputLimit.checkRemainingChars(inputLimitField, characterCountLabel)
        default:
            break
        }
    }
    
    //            MARK: TF4, link
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case linkTextField:
            if openURlTimer != nil {
                openURlTimer?.invalidate()
                openURlTimer = nil
            }
            openURlTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(searchForResult (_:)), userInfo: linkTextField.text!, repeats: false)
            
        default:
            break
        }
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


//            MARK: TF5, password validation rules
    
    func checkValidation (password: String) {
        var capitalCountAlreadyExist = false
        var lowercaseCountAlreadyExist = false
        var digitAlreadyExist = false
        defaultProperties()
        for char in password {
            if String(char).matches(regexOneDigit) && !digitAlreadyExist {
                minOneDigitLabel.textColor = .systemGreen
                minOneDigitLabel.text = "\u{2713}" + " Min 1 digit,"
                colorProgressView ()
                digitAlreadyExist.toggle()
                continue
            } else if String(char).matches(regexOneLowercaseLetter)  && !lowercaseCountAlreadyExist {
                minOneLowercaseLabel.textColor = .systemGreen
                minOneLowercaseLabel.text = "\u{2713}" + " Min 1 lowercase,"
                colorProgressView ()
                lowercaseCountAlreadyExist.toggle()
                continue
            } else if String(char).matches(regexOneCapitalLetter) && !capitalCountAlreadyExist {
                minOneCapitalLabel.textColor = .systemGreen
                minOneCapitalLabel.text = "\u{2713}" + " Min 1 capital required."
                colorProgressView ()
                capitalCountAlreadyExist.toggle()
                continue
            }
        }

        if password.matches(regex) {
            minLengthLabel.text = "\u{2713}" + " Min length 8 characters,"
            minLengthLabel.textColor = .systemGreen
            self.progressView.progress += 2.5/10
            self.progressView.progressTintColor = .green
        }
    }
    
    func defaultProperties () {
        minLengthLabel.textColor = .black
        minLengthLabel.text = "- Min length 8 characters,"
        minOneDigitLabel.textColor = .black
        minOneDigitLabel.text = "- Min 1 digit,"
        minOneLowercaseLabel.textColor = .black
        minOneLowercaseLabel.text = "- Min 1 lowercase,"
        minOneCapitalLabel.textColor = .black
        minOneCapitalLabel.text = "- Min 1 capital required."
        self.progressView.progress = 0
        self.progressView.progressTintColor = .white
        return
    }
    
    func colorProgressView () {
        if self.progressView.progressTintColor == .red || self.progressView.progressTintColor == .orange  {
            self.progressView.progress += 2.5/10
            self.progressView.progressTintColor = .orange
        } else {
            self.progressView.progressTintColor = .red
            self.progressView.progress += 2.5/10 }
    }
}


extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}





