
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
    
    
    public let allowedChars = 10
    let inputLimit = InputLimit()
    var onlyNums = false
    let onlyLetters = OnlyLettersAndOnlyNums()
    
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
            //           MARK: TF3 only letters\dash\only numbers
        case letterDashNumberField:
            if string == "-" && onlyNums == false{
                onlyNums = true
            } else if string == "-" && onlyNums == true {
                onlyNums = false
            }
            return onlyNums ? OnlyLettersAndOnlyNums().onlyNumbers(string: string) : OnlyLettersAndOnlyNums().onlyLetters(string: string)
            //            MARK: TF1, no digits
        case onlyLettersTextField:
            return OnlyLettersAndOnlyNums().onlyLetters(string: string)
            //            MARK: TF3, characters limit
        case inputLimitField:
            inputLimit.checkRemainingChars(inputLimitField, characterCountLabel)
        default:
            break
        }
        return true
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
