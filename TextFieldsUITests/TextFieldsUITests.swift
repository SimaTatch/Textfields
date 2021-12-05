//
//  TextFieldsUITests.swift
//  TextFieldsUITests
//
//  Created by Серафима  Татченкова  on 05.12.2021.
//

import XCTest

class TextFieldsUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    func testGameStyleSwitch() {
        
        let app = XCUIApplication()
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .textField).matching(identifier: "Type here").element(boundBy: 0).tap()
        
        let gKey = app/*@START_MENU_TOKEN@*/.keys["g"]/*[[".keyboards.keys[\"g\"]",".keys[\"g\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        gKey.tap()
        
        let rKey = app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        rKey.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        eKey.tap()
        
        let moreKey = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"numbers\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        moreKey.tap()
        moreKey.tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["4"]/*[[".keyboards.keys[\"4\"]",".keys[\"4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        
        let key2 = app/*@START_MENU_TOKEN@*/.keys["3"]/*[[".keyboards.keys[\"3\"]",".keys[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        key2.tap()
        
        let key3 = app/*@START_MENU_TOKEN@*/.keys["6"]/*[[".keyboards.keys[\"6\"]",".keys[\"6\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key3.tap()
        key3.tap()
        
        let returnButton = app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        returnButton.tap()
        
        let typeHereTextField = element.children(matching: .textField).matching(identifier: "Type here").element(boundBy: 1)
        typeHereTextField.tap()
        typeHereTextField.tap()
        gKey.tap()
        
        let fKey = app/*@START_MENU_TOKEN@*/.keys["f"]/*[[".keyboards.keys[\"f\"]",".keys[\"f\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        fKey.tap()
        app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        eKey.tap()
        
        let tKey = app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tKey.tap()
        
        let yKey = app/*@START_MENU_TOKEN@*/.keys["y"]/*[[".keyboards.keys[\"y\"]",".keys[\"y\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        yKey.tap()
        yKey.tap()
        
        let uKey = app/*@START_MENU_TOKEN@*/.keys["u"]/*[[".keyboards.keys[\"u\"]",".keys[\"u\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        uKey.tap()
        uKey.tap()
        uKey.tap()
        uKey.tap()
        uKey.tap()
        uKey.tap()
        uKey.tap()
        uKey.tap()
        uKey.tap()
        uKey.tap()
        typeHereTextField.tap()
        typeHereTextField.tap()
        
        let deleteKey = app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards.keys[\"delete\"]",".keys[\"delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        deleteKey.tap()
        deleteKey.tap()
        app.textFields["wwwww-ddddd"].tap()
        fKey.tap()
        fKey.tap()
        gKey.tap()
        
        let dKey = app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".keyboards.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        dKey.tap()
        dKey.tap()
        moreKey.tap()
        moreKey.tap()
        key2.tap()
        key2.tap()
        
        let key4 = app/*@START_MENU_TOKEN@*/.keys["-"]/*[[".keyboards.keys[\"-\"]",".keys[\"-\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key4.tap()
        key4.tap()
        app/*@START_MENU_TOKEN@*/.keys["5"]/*[[".keyboards.keys[\"5\"]",".keys[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        key.tap()
        key.tap()
        key.tap()
        key.tap()
        key.tap()
        returnButton.tap()
        
        let wwwExampleComTextField = app.textFields["www.example.com"]
        wwwExampleComTextField.tap()
        wwwExampleComTextField.tap()
        app/*@START_MENU_TOKEN@*/.menuItems["Paste"]/*[[".menus.menuItems[\"Paste\"]",".menuItems[\"Paste\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        element.tap()
        app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.statusBars.buttons["breadcrumb"]/*[[".windows[\"SBSwitcherWindow\"]",".otherElements[\"AppSwitcherContentView\"]",".otherElements[\"card:com.apple.mobilesafari:sceneID:com.apple.mobilesafari-80A56E93-60D5-4381-81A5-3A37128E5A96\"].scrollViews.otherElements.statusBars",".buttons[\"Return to TextFields\"]",".buttons[\"breadcrumb\"]",".scrollViews.otherElements.statusBars"],[[[-1,5,3],[-1,2,3],[-1,1,2],[-1,0,1]],[[-1,5,3],[-1,2,3],[-1,1,2]],[[-1,5,3],[-1,2,3]],[[-1,4],[-1,3]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        
        let cKey = app/*@START_MENU_TOKEN@*/.keys["c"]/*[[".keyboards.keys[\"c\"]",".keys[\"c\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cKey.tap()
        cKey.tap()
        eKey.tap()
        eKey.tap()
        app/*@START_MENU_TOKEN@*/.buttons["shift"]/*[[".keyboards.buttons[\"shift\"]",".buttons[\"shift\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["A"]/*[[".keyboards.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        aKey.tap()
        moreKey.tap()
        moreKey.tap()
        key.tap()
        key.tap()
        app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"letters\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        dKey.tap()
        fKey.tap()
        app/*@START_MENU_TOKEN@*/.keys["s"]/*[[".keyboards.keys[\"s\"]",".keys[\"s\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        eKey.tap()
        rKey.tap()
        tKey.tap()
        tKey.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        deleteKey.tap()
        deleteKey.tap()
        element.tap()
        
    }


}
