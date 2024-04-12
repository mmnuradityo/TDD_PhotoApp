//
//  SignupFromModelValidator.swift
//  PhotoAppTests
//
//  Created by Admin on 11/04/24.
//

import XCTest
@testable import PhotoApp

// MARK: First name
final class SignupFromModelValidatorTests_ValidationFirstName: XCTestCase {
  
  // Arrange
  var sut: SignupFromModelValidator!
  
  override func setUpWithError() throws {
    sut = SignupFromModelValidator()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  /**
   * Naming for variables
   * sut: System Under Test
   */
  func testSignupFromModelValidator_WhenValidFirstNameProvided_ShouldReturnTrue() {
    
    // Act
    let isFirstNameValid = sut.isFirstNameValid(firstName: "FirstName")
    
    // Assert
    XCTAssertTrue(isFirstNameValid, "The isFirstNameValid() should have return TRUE for a valid first name but returned FALSE")
  }
  
  func testSignupFromModelValidator_WhenTooShortFirstNameProvided_ShouldreturnFalse() {
    
    // Act
    let isFirstNameValid = sut.isFirstNameValid(firstName: "F")
    
    // Assert
    XCTAssertFalse(
      isFirstNameValid,
      "The isFirstNameValid() should have return FALSE for a valid first name that is shorter than \(SignupConstanats.inputNameMinLenght) characters but is as return TRUE"
    )
  }
  
  func testSignupFromModelValidator_WhenTooLongFirstNameProvided_ShouldReturnFalse() {
    
    // Act
    let isFirstNameValid = sut.isFirstNameValid(firstName: "FirstNameFirstName")
    
    // Assert
    XCTAssertFalse(
      isFirstNameValid,
      "The isFirstNameValid() should have return FALSE for a valid first name that is longer than \(SignupConstanats.inputNameMaxLenght) characters but is as return TRUE"
    )
  }
  
  func testSignupFromModelValidator_WhenContainNumbersFirstNameProvided_ShouldReturnFalse() {
    
    // Act
    let isFirstNameValid = sut.isFirstNameValid(firstName: "FirstName1")
    
    // Assert
    XCTAssertFalse(
      isFirstNameValid,
      "The isFirstNameValid() should have to return FALSE for a valid first name that Ccntains Numbers than is return TRUE"
    )
  }
  
  func testSignupFromModelValidator_WhenContainSpecialCharactersFirstNameProvided_ShouldReturnFalse() {
    
    // Act
    let isFirstNameValid = sut.isFirstNameValid(firstName: "FirstName!")
    
    // Assert
    XCTAssertFalse(
      isFirstNameValid,
      "The isFirstNameValid() should have to return FALSE for a valid first name that contains Special Characters than is return TRUE"
    )
  }
  
}

// MARK: Last name
final class SignupFromModelValidatorTests_ValidationLastName: XCTestCase {
  
  // Arrange
  var sut: SignupFromModelValidator!
  
  override func setUpWithError() throws {
    sut = SignupFromModelValidator()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  /**
   * Naming for variables
   * sut: System Under Test
   */
  func testSignupFromModelValidator_WhenValidLastNameProvided_ShouldReturnTrue() {
    
    // Act
    let isLastNameValid = sut.isLastNameValid(lastName: "LastName")
    
    // Assert
    XCTAssertTrue(isLastNameValid, "The isLastNameValid() should have return TRUE for valid last name but returned FALSE")
  }
  
  func testSignupFromModelValidator_WhenTooShortLastNameProvided_ShouldreturnFalse() {
    
    // Act
    let isLastNameValid = sut.isLastNameValid(lastName: "L")
    
    // Assert
    XCTAssertFalse(
      isLastNameValid,
      "The isLastNameValid() should have return FALSE for valid last name that is shorter than \(SignupConstanats.inputNameMinLenght) characters but is as return TRUE"
    )
  }
  
  func testSignupFromModelValidator_WhenTooLongLastNameProvided_ShouldReturnFalse() {
    
    // Act
    let isLastNameValid = sut.isLastNameValid(lastName: "LastNameLastName")
    
    // Assert
    XCTAssertFalse(
      isLastNameValid,
      "The isLastNameValid() should have return FALSE for valid last name that is longer than \(SignupConstanats.inputNameMaxLenght) characters but is as return TRUE"
    )
  }
  
  func testSignupFromModelValidator_WhenContainNumbersLastNameProvided_ShouldReturnFalse() {
    
    // Act
    let isLastNameValid = sut.isLastNameValid(lastName: "LastName1")
    
    // Assert
    XCTAssertFalse(
      isLastNameValid,
      "The isLastNameValid() should have to return FALSE for a valid last name that Ccntains Numbers than is return TRUE"
    )
  }
  
  func testSignupFromModelValidator_WhenContainSpecialCharactersFirstNameProvided_ShouldReturnFalse() {
    
    // Act
    let isLastNameValid = sut.isLastNameValid(lastName: "LastName!")
    
    // Assert
    XCTAssertFalse(
      isLastNameValid,
      "The isLastNameValid() should have to return FALSE for a valid Last name that contains Special Characters than is return TRUE"
    )
  }
  
}

// MARK: Email
final class SignupFromModelValidatorTests_ValidationEmail: XCTestCase {
  
  // Arrange
  var sut: SignupFromModelValidator!
  
  override func setUpWithError() throws {
    sut = SignupFromModelValidator()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  /**
   * Naming for variables
   * sut: System Under Test
   */
  func testSignupFromModelValidator_WhenValidEmailProvided_ShouldReturnTrue() {
    // Act
    let isEmailValid = sut.isEmailValid(email: "email@email.com")
    
    // Assert
    XCTAssertTrue(isEmailValid, "The isEmailValid() should have return TRUE for valid password but returned FALSE")
  }
  
  func testSignupFromModelValidator_WhenValidEmailContainNumbersProvided_ShouldReturnTrue() {
    // Act
    let isEmailValid = sut.isEmailValid(email: "email1@email.com")
    
    // Assert
    XCTAssertTrue(isEmailValid, "The isEmailValid() should have return TRUE for valid password but returned FALSE")
  }
  
  func testSignupFromModelValidator_WhenValidEmailContainUnderscoreProvided_ShouldReturnTrue() {
    // Act
    let isEmailValid = sut.isEmailValid(email: "email_email@email.com")
    
    // Assert
    XCTAssertTrue(isEmailValid, "The isEmailValid() should have return TRUE for valid password but returned FALSE")
  }
  
  func testSignupFromModelValidator_WhenNotValidEmailContainSpecialCharactersProvided_ShouldReturnFalse() {
    // Act
    let isEmailValid = sut.isEmailValid(email: "email$@email.com")
    
    // Assert
    XCTAssertFalse(isEmailValid, "The isEmailValid() should have return FALSE for valid password but returned TRUE")
  }
  
  func testSignupFromModelValidator_WhenNotValidEmailContainSpaceCharactersProvided_ShouldReturnFalse() {
    // Act
    let isEmailValid = sut.isEmailValid(email: "emai email@email.com")
    
    // Assert
    XCTAssertFalse(isEmailValid, "The isEmailValid() should have return FALSE for valid password but returned TRUE")
  }
  
}

// MARK: Password
final class SignupFromModelValidatorTests_ValidationNewPasword: XCTestCase {
  
  // Arrange
  var sut: SignupFromModelValidator!
  
  override func setUpWithError() throws {
    sut = SignupFromModelValidator()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  /**
   * Naming for variables
   * sut: System Under Test
   */
  func testSignupFromModelValidator_WhenValidNewPasswordProvided_ShouldReturnTrue() {
    
    // Act
    let isNewPasswordValid = sut.isNewPasswordValid(password: "NewPassword12!@#")
    
    // Assert
    XCTAssertTrue(isNewPasswordValid, "The isNewPasswordValid() should have return TRUE for valid password but returned FALSE")
  }
  
  func testSignupFromModelValidator_WhenTooShortNewPasswordProvided_ShouldreturnFalse() {
    
    // Act
    let isNewPasswordValid = sut.isNewPasswordValid(password: "N")
    
    // Assert
    XCTAssertFalse(
      isNewPasswordValid,
      "The isNewPasswordValid() should have return FALSE for valid password that is shorter than \(SignupConstanats.passwordMinLenght) characters but is as return TRUE"
    )
  }
  
  // password must be contain number and special caracter
  func testSignupFromModelValidator_WhenNewPasswordNotMatcherCriteriaProvided_ShouldReturnFalse() {
    
    // Act
    let isNewPasswordValid = sut.isNewPasswordValid(password: "NewPassword")
    
    // Assert
    XCTAssertFalse(isNewPasswordValid, "The isNewPasswordValid() should have return FASLE for valid password but returned TRUE")
  }
  
  func testSignupFromModelValidator_WhenNewPasswordContainNotValidSpecialCharactersProvided_ShouldReturnFalse() {
    
    // Act
    let isNewPasswordValid = sut.isNewPasswordValid(password: "Password1![")
    
    // Assert
    XCTAssertFalse(
      isNewPasswordValid,
      "The isNewPasswordValid() should have to return FALSE for a valid password that contains not valid Special Characters than is return TRUE"
    )
  }
  
  func testSignupFromModelValidator_WhenRepeatePasswordEqualPasswordProvided_ShouldReturnTrue() {
    
    // Arrange
    let password = "NewPassword12@#"
    let repeatePassword = "NewPassword12@#"
    
    // Act
    let doPasswordMatch = sut.doPasswordMatch(password: password, repeatePassword: repeatePassword)
    
    // Assert
    XCTAssertTrue(
      doPasswordMatch,
      "The doPasswordMatch() should have to return TRUE for a repeate password that not match with new password than is return FALSE"
    )
  }
  
  func testSignupFromModelValidator_WhenRepeatePasswordNotEqualPasswordProvided_ShouldReturnFalse() {
    
    // Arrange
    let password = "NewPassword12@#"
    let repeatePassword = "NewPassword12@$%67"
    
    // Act
    let doPasswordMatch = sut.doPasswordMatch(password: password, repeatePassword: repeatePassword)
    
    // Assert
    XCTAssertFalse(
      doPasswordMatch,
      "The doPasswordMatch() should have to return TRUE for a repeate password that not match with new password than is return FALSE"
    )
  }
  
}
