//
//  PhotoAppUITests.swift
//  PhotoAppUITests
//
//  Created by Admin on 19/04/24.
//

import XCTest

final class SignupFlowUITests: XCTestCase {
  
  var app: XCUIApplication!
  var firstName: XCUIElement!
  var lastName: XCUIElement!
  var email: XCUIElement!
  var password: XCUIElement!
  var confirmationPassword: XCUIElement!
  var signupButton: XCUIElement!
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    try super.setUpWithError()
    app = XCUIApplication()
    app.launchArguments = ["-skinSurvey", "-debugServer"]
    
    // manual set environment values
//    app.launchEnvironment = [
//      "signupUrl" : "https://www.appsdeveloperblog.com/api/v2/users/signup-mock-service/users",
//      "inAppPurchaseEnable" : "true",
//      "inAppAdsEnable" : "true"
//    ]
    
    // get enveronment values from testplan configuration variables
    // first set default configuration scheme to testplan we will get environment values
    // and run with right click and choose run then select specific configuration
    app.launchEnvironment = ProcessInfo.processInfo.environment
    app.launch()
    
    firstName = app.textFields["firstNameTextField"]
    lastName = app.textFields["lastNameTextField"]
    email = app.textFields["emailTextField"]
    password = app.secureTextFields["passwordTextField"]
    confirmationPassword = app.secureTextFields["confirmationPasswordTextField"]
    signupButton = app.buttons["signupButton"]
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    app = nil
    firstName = nil
    lastName = nil
    email = nil
    password = nil
    confirmationPassword = nil
    signupButton = nil
    try super.tearDownWithError()
  }
  
  func testSignupViewController_WhenViewIsLoaded_TheRequiredUiElementAreEnabled() throws {
    // Assert
    XCTAssertTrue(firstName.isEnabled, "First Name UITextField is not enable for user interactions")
    XCTAssertTrue(lastName.isEnabled, "Last Name UITextField is not enable for user interactions")
    XCTAssertTrue(email.isEnabled, "Email UITextField is not enable for user interactions")
    XCTAssertTrue(password.isEnabled, "Password UITextField is not enable for user interactions")
    XCTAssertTrue(confirmationPassword.isEnabled, "Confirmation Password UITextField is not enable for user interactions")
    XCTAssertTrue(signupButton.isEnabled, "Signup Button is not enable for user interactions")
  }
  
  func testSignupViewController_WhenInvalidFormIsTapped_PresentedErrorAlertDialog() {
    // Arrange
    firstName.tap()
    firstName.typeText("F")
    
    lastName.tap()
    lastName.typeText("L")
    
    email.tap()
    email.typeText("@")
    
    password.tap()
    password.typeText("12345")
    
    confirmationPassword.tap()
    confirmationPassword.typeText("123")
    
    app.staticTexts["signupTitleLable"].tap()
        
    // Act
    signupButton.tap()
    
    let emailScreenshot = email.screenshot()
    let emailAtacment = XCTAttachment(screenshot: emailScreenshot)
    emailAtacment.name = "Screenshot of Email TextField"
    emailAtacment.lifetime = .keepAlways
    add(emailAtacment)
    
//    let currentAppWindow = app.screenshot()
    let currentAppWindow = XCUIScreen.main.screenshot()
    let appAtacment = XCTAttachment(screenshot: currentAppWindow)
    appAtacment.name = "Signup page screenshot"
    appAtacment.lifetime = .keepAlways
    add(appAtacment)
    
    // Assert
    XCTAssertTrue(
      app.alerts["errorAlertDialog"].waitForExistence(timeout: 5),
      "An Error Alert Dialog was not presented when an invalid form was submitted"
    )
  }
  
  func testSignupViewController_WhenVlidFormIsTapped_PresentedSuccessAlertDialog() {
    // Arrange
    firstName.tap()
    firstName.typeText("Firstname")
    
    lastName.tap()
    lastName.typeText("Lastname")
    
    email.tap()
    email.typeText("email@mail.com")
    
    password.tap()
    password.typeText("Password!23")
    
    confirmationPassword.tap()
    confirmationPassword.typeText("Password!23")
    
    app.staticTexts["signupTitleLable"].tap()
        
    // Act
    signupButton.tap()
    
    // Assert
    XCTAssertTrue(
      app.alerts["successAlertDialog"].waitForExistence(timeout: 5),
      "An Success Alert Dialog was not presented when an valid form was submitted"
    )
  }

  // disable this test for now
//  func testLaunchPerformance() throws {
//    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//      // This measures how long it takes to launch your application.
//      measure(metrics: [XCTApplicationLaunchMetric()]) {
//        XCUIApplication().launch()
//      }
//    }
//  }
}
