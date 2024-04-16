//
//  SignupViewCintrollerTests.swift
//  PhotoAppTests
//
//  Created by Admin on 16/04/24.
//

import XCTest
@testable import PhotoApp

final class SignupViewCintrollerTests: XCTestCase {
  
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
  
  func testSignupViewCintroller_WhenSignupButtontapped_InvokeSignupProccess() {
    // Arrange
    let mockSignupModelValidator = MockSignupModelValidator()
    let mockSignupWebService = MockSignupWebService()
    let mockSignupViewDelegate = MockSignupViewDelegate()
    
    let mockSignupPresenter = MockSignupPresenter(
      formModelValidator: mockSignupModelValidator,
      webService: mockSignupWebService,
      delegate: mockSignupViewDelegate
    )
    sut.presenter = mockSignupPresenter
    
    // Act
    sut.signupButton.sendActions(for: .touchUpInside)
    
    // Assert
    XCTAssertTrue(
      mockSignupPresenter.proccessUserSignupCalled,
      "The proccessSignupButton() method was not called on a Presenter object when the signup button was tapped in a SignupViewController"
    )
  }
}

