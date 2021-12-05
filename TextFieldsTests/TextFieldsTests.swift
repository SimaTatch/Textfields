
import XCTest
@testable import TextFields


class TextFieldsTests: XCTestCase {
    

    
//      TF1
    func testonlyLettersCheck () {
        let onlyLetters = OnlyLettersAndOnlyNums()
        let field = "G6tyi876hkj"
        var result = ""
        for char in field {
            if char.isLetter {
                continue
            } else {
                result.append(char)
            }
        }
        let expectedResult = false
        let testResult = onlyLetters.onlyLetters(string: result)
        XCTAssertEqual(expectedResult, testResult)
    }
//      TF3
    func testShoulAddCharacterToDashField () {
        let onlyLetters = OnlyLettersAndOnlyNums()
        let previousText = "ygg"
        let str = "4"
        let shouldAddChar = onlyLetters.shoudAddCharecterToDashField(string: str, previousText: previousText)
        XCTAssertFalse(shouldAddChar)
    }
    
}
