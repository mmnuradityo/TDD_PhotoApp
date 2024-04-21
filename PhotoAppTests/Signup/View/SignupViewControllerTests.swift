//
//  SignupViewCintrollerTests.swift
//  PhotoAppTests
//
//  Created by Admin on 16/04/24.
//

import XCTest
@testable import PhotoApp

final class SignupViewCintrollerTests_InitialView: XCTestCase {
  
  var storyboard: UIStoryboard!
  var sut: SignupViewController!
  
  override func setUpWithError() throws {
    storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    sut = storyboard.instantiateViewController(identifier: "SignupViewController") as SignupViewController
    sut.loadViewIfNeeded()
  }
  
  override func tearDownWithError() throws {
    storyboard = nil
    sut = nil
  }
  
  func testSignupViewCintroller_WhenCreated_HasRequierdTextfieldEmpty() throws {
    // Assert
    let firstNameTextField = try XCTUnwrap(
      sut.userFirstNameTextField, "The userFirstNameTextField is not connected to be an IBOutlet"
    )
    let lastNameTextField = try XCTUnwrap(
      sut.userLastNameTextField, "The userLastNameTextField is not connected to be an IBOutlet"
    )
    let emailTextField = try XCTUnwrap(
      sut.userEmailTextField, "The userEmailTextField is not connected to be an IBOutlet"
    )
    let passwordTextField = try XCTUnwrap(
      sut.userPasswordTextField, "The userPasswordTextField is not connected to be an IBOutlet"
    )
    let passwordConfirmationTextField = try XCTUnwrap(
      sut.userPasswordConfirmationTextField, "The userPasswordConfirmationTextField is not connected to be an IBOutlet"
    )
    
    XCTAssertEqual(
      firstNameTextField.text, "",
      "First name text field was not empty when the view contoller initially loaded"
    )
    XCTAssertEqual(
      lastNameTextField.text, "",
      "Last name text field was not empty when the view contoller initially loaded"
    )
    XCTAssertEqual(
      emailTextField.text, "",
      "email text field was not empty when the view contoller initially loaded"
    )
    XCTAssertEqual(
      passwordTextField.text, "",
      "Password text field was not empty when the view contoller initially loaded"
    )
    XCTAssertEqual(
      passwordConfirmationTextField.text, "",
      "Password confirmation text field was not empty when the view contoller initially loaded"
    )
  }
  
  func testSignupViewCintroller_WhenCreated_HasSignupButtonAndAction() throws {
    // Arrange
    let signupButton: UIButton = try XCTUnwrap(
      sut.signupButton, "The signupButton is not connected to be an IBOutlet"
    )
    
    // Act
    let signupButtonActions = try XCTUnwrap(
      signupButton.actions(forTarget: sut, forControlEvent: .touchUpInside),
      "The Signup Button does not have any actions assigned to it"
    )
    
    // Assert
    XCTAssertEqual(
      signupButtonActions.count, 1,
      "The Signup Button does not have any ctions assign to it"
    )
    XCTAssertEqual(
      signupButtonActions.first, "signupButtonTapped:",
      "There is no action with a name signupButtonTapped assigned to signup button"
    )
  }
  
}

final class SignupViewCintrollerTests_Attributes: XCTestCase {
  
  var storyboard: UIStoryboard!
  var sut: SignupViewController!
  
  override func setUpWithError() throws {
    storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    sut = storyboard.instantiateViewController(identifier: "SignupViewController") as SignupViewController
    sut.loadViewIfNeeded()
  }
  
  override func tearDownWithError() throws {
    storyboard = nil
    sut = nil
  }
  
  func testSignupViewCintroller_WhenCreated_HasEmailAddressContentTypeSet() throws {
    // Arrange
    let emailTextfield = try XCTUnwrap(sut.userEmailTextField, "The userEmailTextField is not connected to be an IBOutlet")
    
    // Act
    let emailTextfieldContentType = emailTextfield.textContentType
    
    // Assert
    XCTAssertEqual(
      emailTextfieldContentType, UITextContentType.emailAddress,
      "The email text field does not have the email address content type set"
    )
  }
  
  func testSignupViewCintroller_WhenEmailTextfieldIsFirstResponder_HasKeyboardTypeSet() throws {
    // Arrange
    let emailTextfield = try XCTUnwrap(sut.userEmailTextField, "The userEmailTextField is not connected to be an IBOutlet")
    
    // Act
    emailTextfield.becomeFirstResponder()
    let emailTextfieldKeyboardType = emailTextfield.keyboardType
    
    // Assert
    XCTAssertEqual(
      emailTextfieldKeyboardType, UIKeyboardType.emailAddress,
      "The email text field does not have the email address keyboard type set"
    )
  }
  
  func testSignupViewCintroller_WhenCreated_HasPasswordIsSecureTextEntry() throws {
    // Arrange
    let passwordTextfield = try XCTUnwrap(sut.userPasswordTextField, "The userPasswordTextField is not connected to be an IBOutlet")
    
    // Act
    let passwordTextfieldIsSecureTextEntry = passwordTextfield.isSecureTextEntry
    
    // Assert
    XCTAssertTrue(
      passwordTextfieldIsSecureTextEntry,
      "The password text field does not have the secure text entry set"
    )
  }
  
  func testSignupViewCintroller_WhenCreated_HasConfirmationPasswordIsSecureTextEntry() throws {
    // Arrange
    let passwordConfirmationTextfield = try XCTUnwrap(sut.userPasswordConfirmationTextField, "The userPasswordConfirmationTextField is not connected to be an IBOutlet")
    
    // Act
    let passwordConfirmationTextfieldIsSecureTextEntry = passwordConfirmationTextfield.isSecureTextEntry
    
    // Assert
    XCTAssertTrue(
      passwordConfirmationTextfieldIsSecureTextEntry,
      "The password confirmation text field does not have the secure text entry set"
    )
  }
}

final class SignupViewCintrollerTests_Navigations: XCTestCase {
  
  var storyboard: UIStoryboard!
  var sut: SignupViewController!
  var mockSignupModelValidator: MockSignupModelValidator!
  var mockSignupWebService: MockSignupWebService!
  var mockSignupViewDelegate: MockSignupViewDelegate!
  var mockSignupPresenter: MockSignupPresenter!
  
  override func setUpWithError() throws {
    storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    sut = storyboard.instantiateViewController(identifier: "SignupViewController") as SignupViewController
    sut.loadViewIfNeeded()
    
    mockSignupModelValidator = MockSignupModelValidator()
    mockSignupWebService = MockSignupWebService()
    mockSignupViewDelegate = MockSignupViewDelegate()
    
    mockSignupPresenter = MockSignupPresenter(
      formModelValidator: mockSignupModelValidator,
      webService: mockSignupWebService,
      delegate: mockSignupViewDelegate
    )
    sut.presenter = mockSignupPresenter
  }
  
  override func tearDownWithError() throws {
    storyboard = nil
    sut = nil
    mockSignupModelValidator = nil
    mockSignupWebService = nil
    mockSignupViewDelegate = nil
    mockSignupPresenter = nil
  }
  
  func testSignupViewController_WhenButtonTapped_callsSignupPresenterProcessUserSignupAndSuccessfull() {
    // Arrange
    let expectation = self.expectation(description: "Expectation is succesfullSignup() method to be called")
    mockSignupViewDelegate.expectation = expectation
    
    // Act
    sut.signupButton.sendActions(for: .touchUpInside)
    self.wait(for: [expectation], timeout: 5)
    
    // Assert
    XCTAssertTrue(
      mockSignupPresenter.proccessUserSignupCalled,
      "The proccessSignupButton() method was not called on a Presenter object when the signup button was tapped in a SignupViewController"
    )
    XCTAssertTrue(
      mockSignupViewDelegate.successfullSignupCounter == 1,
      "successfullSignupCounter mustbe call once when the signup button was tapped in a SignupViewController"
    )
  }
  
  func testSignupViewController_WhenButtonTapped_DetailViewControllerCanBePushed() {
    // Act
    sut.successfulSignup()
    
    // Wait for the segue to complete
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      // Assert
      guard let presentedViewController = self.sut.presentedViewController else {
        XCTFail("The presentedViewController should not be nil")
        return
      }
      
      XCTAssertTrue(presentedViewController is DetailViewController, "The presentedViewController should be a DetailViewController")
    }
  }
  
  func testSignupViewController_WhenButtonTapped_callsSignupPresenterProcessUserSignupAndError() {
    // Arrange
    let expectation = self.expectation(description: "Expectation is succesfullSignup() method to be called")
    mockSignupViewDelegate.expectation = expectation
    
    let error = SignupError.failedRequest(description: "Error")
    mockSignupPresenter.error = error
    
    // Act
    sut.signupButton.sendActions(for: .touchUpInside)
    self.wait(for: [expectation], timeout: 5)
    
    // Assert
    XCTAssertTrue(
      mockSignupPresenter.proccessUserSignupCalled,
      "The proccessSignupButton() method was not called on a Presenter object when the signup button was tapped in a SignupViewController"
    )
    XCTAssertTrue(
      mockSignupViewDelegate.errorSignupCounter == 1,
      "errorSignupCounter mustbe call once when the signup button was tapped in a SignupViewController"
    )
    XCTAssertEqual(mockSignupViewDelegate.error, error)
  }
  
  func testSignupViewController_WhenButtonTapped_ErrorHandlerMustBeCalled() {
    // Arrange
    let error = SignupError.failedRequest(description: "Error")
    
    // Act
    sut.errorHandler(error: error)
  }

  func testSignupViewController_WhenButtonTapped_TryToHandleError() {
    // Arrange
    mockSignupModelValidator.firstNameValidated = MockSignupModelValidator.STATUS_ERROR
    
    let error = SignupError.failedRequest(description: "Error")
    mockSignupPresenter.error = error
    
    // Act
    sut.signupButton.sendActions(for: .touchUpInside)
    
    // Assert
    XCTAssertTrue(
      mockSignupPresenter.proccessUserSignupCalled,
      "The proccessSignupButton() method was not called on a Presenter object when the signup button was tapped in a SignupViewController"
    )
    XCTAssertEqual(mockSignupPresenter.error, error)
  }
}
