//
//  SignupPresenterTests.swift
//  PhotoAppTests
//
//  Created by Admin on 16/04/24.
//

import XCTest
@testable import PhotoApp

final class SignupPresenterTests: XCTestCase {
  
  var signupFormModel: SignupFormModel!
  var mockSignupModelValidator: MockSignupModelValidator!
  var mockSignupWebService: MockSignupWebService!
  var mockSignupViewDelegate: MockSignupViewDelegate!
  var sut: SignupPresenter!
  
  override func setUpWithError() throws {
    signupFormModel = SignupFormModel(
      email: "email@email.com", firstName: "FirstName", lastName: "LastName", password: "Password!23", confirmPassword: "Password!23"
    )
    
    mockSignupModelValidator = MockSignupModelValidator()
    mockSignupWebService = MockSignupWebService()
    mockSignupViewDelegate = MockSignupViewDelegate()
    
    sut = SignupPresenter(
      formModelValidator: mockSignupModelValidator, webService: mockSignupWebService, delegate: mockSignupViewDelegate
    )
  }
  
  override func tearDownWithError() throws {
    signupFormModel = nil
    mockSignupModelValidator = nil
    mockSignupWebService = nil
    mockSignupViewDelegate = nil
    sut = nil
  }
  
  func testSignupPresenter_WhenInformationProvided_WillValidateEachProperty() {
    
    // Act & Assert
    XCTAssertNoThrow(try sut.processUserSinup(formModel: signupFormModel))
    
    XCTAssertTrue(
      mockSignupModelValidator.validate(count: mockSignupModelValidator.firstNameValidated),
      "First Name was not validated"
    )
    XCTAssertTrue(
      mockSignupModelValidator.validate(count: mockSignupModelValidator.lastNameValidated),
      "Last Name was not validated"
    )
    XCTAssertTrue(
      mockSignupModelValidator.validate(count: mockSignupModelValidator.emailFormatValidatetd),
      "Email Format was not validated"
    )
    XCTAssertTrue(
      mockSignupModelValidator.validate(count: mockSignupModelValidator.passwordValidated),
      "Psssword was not validated"
    )
    XCTAssertTrue(
      mockSignupModelValidator.validate(count: mockSignupModelValidator.passwordEqualityValidated),
      "Did not validate if passwords match"
    )
  }
  
  func testSignupPresenter_WhenFirstNameNotValidatedProvided_WillValidateEachProperty() {
    // Arrange
    mockSignupModelValidator.firstNameValidated = MockSignupModelValidator.STATUS_ERROR
    
    // Act & Assert
    XCTAssertThrowsError(
      try sut.processUserSinup(formModel: signupFormModel),
      "The isFirstNameValid() method should be thrown an error"
    ) { error in
      XCTAssertEqual(error as? SignupError, SignupError.invalidFirstName)
    }
    XCTAssertFalse(
      mockSignupModelValidator.validate(count: mockSignupModelValidator.firstNameValidated),
      "First Name was not validated"
    )
  }
  
  func testSignupPresenter_WhenLastNameNotValidatedProvided_WillValidateEachProperty() {
    // Arrange
    mockSignupModelValidator.lastNameValidated = MockSignupModelValidator.STATUS_ERROR
    
    // Act & Assert
    XCTAssertThrowsError(
      try sut.processUserSinup(formModel: signupFormModel),
      "The isLastNameValid() method should be thrown an error"
    ) { error in
      XCTAssertEqual(error as? SignupError, SignupError.invalidLastName)
    }
    XCTAssertFalse(
      mockSignupModelValidator.validate(count: mockSignupModelValidator.lastNameValidated),
      "Last Name was not validated"
    )
  }
  
  func testSignupPresenter_WhenEmailNotValidatedProvided_WillValidateEachProperty() {
    // Arrange
    mockSignupModelValidator.emailFormatValidatetd = MockSignupModelValidator.STATUS_ERROR
    
    // Act & Assert
    XCTAssertThrowsError(
      try sut.processUserSinup(formModel: signupFormModel),
      "The isEmailValid() method should be thrown an error"
    ) { error in
      XCTAssertEqual(error as? SignupError, SignupError.invalidEmail)
    }
    XCTAssertFalse(
      mockSignupModelValidator.validate(count: mockSignupModelValidator.emailFormatValidatetd),
      "Email format was not validated"
    )
  }
  
  func testSignupPresenter_WhenPasswordValidatedProvided_WillValidateEachProperty() {
    // Arrange
    mockSignupModelValidator.passwordValidated = MockSignupModelValidator.STATUS_ERROR
    
    // Act & Assert
    XCTAssertThrowsError(
      try sut.processUserSinup(formModel: signupFormModel),
      "The isNewPasswordValid() method should be thrown an error"
    ) { error in
      XCTAssertEqual(error as? SignupError, SignupError.invalidPassword)
    }
    XCTAssertFalse(
      mockSignupModelValidator.validate(count: mockSignupModelValidator.passwordValidated),
      "Password was not validated"
    )
  }
  
  func testSignupPresenter_WhenPasswordEqualityDidNotMatch_WillValidateEachProperty() {
    // Arrange
    mockSignupModelValidator.passwordEqualityValidated = MockSignupModelValidator.STATUS_ERROR
    
    // Act & Assert
    XCTAssertThrowsError(
      try sut.processUserSinup(formModel: signupFormModel),
      "The doPasswordMatch() method should be thrown an error"
    ) { error in
      XCTAssertEqual(error as? SignupError, SignupError.invalidConfirmationPassword)
    }
    XCTAssertFalse(
      mockSignupModelValidator.validate(count: mockSignupModelValidator.passwordEqualityValidated),
      "Did not validate if passwords match"
    )
  }
  
  func testSignupPresenter_WhenGivenValidFormModel_ShouldCallSignupMethod() throws {
    
    // Act
    try sut.processUserSinup(formModel: signupFormModel)
    
    // Assert
    XCTAssertTrue(mockSignupWebService.isSignupMethodCalled, "The signup() method was not called in the SignupWebService class")
  }
  
  func testSignupPresenter_WhenSginupOperasionSuccessfull_CallSuccessOnViewDelegate() throws {
    // Arrange
    let expectation = self.expectation(description: "Expectation is succesfullSignup() method to be called")
    mockSignupViewDelegate.expectation = expectation
    
    // Act
    try sut.processUserSinup(formModel: signupFormModel)
    self.wait(for: [expectation], timeout: 5)
    
    // Assert
    
    XCTAssertEqual(
      mockSignupViewDelegate.successfullSignupCounter, 1,
      "The successfullSignup() method was called more than 1 time"
    )
    XCTAssertEqual(
      mockSignupViewDelegate.errorSignupCounter, 0,
      "The errorSignup() shold be not called"
    )
  }
  
  func testSignupPresenter_WhenSginupOperasionError_CallErrorHandlerOnViewDelegate() throws {
    // Arrange
    let expectation = self.expectation(description: "Expectation is errorSignup() method to be called")
    let errorDescription = "Signup request was not successful"
    mockSignupWebService.error = SignupError.failedRequest(description: errorDescription)
    mockSignupViewDelegate.expectation = expectation
    
    // Act
    try sut.processUserSinup(formModel: signupFormModel)
    self.wait(for: [expectation], timeout: 5)
    
    // Assert
    
    XCTAssertEqual(
      mockSignupViewDelegate.errorSignupCounter, 1,
      "The errorSignup() method was called more than 1 time"
    )
    XCTAssertEqual(
      mockSignupViewDelegate.successfullSignupCounter, 0,
      "The successfullSignup() shold be not called"
    )
    XCTAssertNotNil(mockSignupViewDelegate.error)
    XCTAssertEqual(mockSignupWebService.error?.localizedDescription, errorDescription)
  }
  
}
