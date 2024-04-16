//
//  MockSignupModelValidator.swift
//  PhotoAppTests
//
//  Created by Admin on 16/04/24.
//

import Foundation
@testable import PhotoApp

class MockSignupModelValidator: SignupModelValidatorProtocol {
  
  static let STATUS_NOT_CALL = 0
  static let STATUS_CALL = 1
  static let STATUS_ERROR = 2
  
  var firstNameValidated: Int = MockSignupModelValidator.STATUS_NOT_CALL
  var lastNameValidated: Int = MockSignupModelValidator.STATUS_NOT_CALL
  var emailFormatValidatetd: Int = MockSignupModelValidator.STATUS_NOT_CALL
  var passwordValidated: Int = MockSignupModelValidator.STATUS_NOT_CALL
  var passwordEqualityValidated: Int = MockSignupModelValidator.STATUS_NOT_CALL
  
  func isFirstNameValid(firstName: String) -> Bool {
    firstNameValidated += 1
    return validate(count: firstNameValidated)
  }
  
  func isLastNameValid(lastName: String) -> Bool {
    lastNameValidated += 1
    return validate(count: lastNameValidated)
  }
  
  func isEmailValid(email: String) -> Bool {
    emailFormatValidatetd += 1
    return validate(count: emailFormatValidatetd)
  }
  
  func isNewPasswordValid(password: String) -> Bool {
    passwordValidated += 1
    return validate(count: passwordValidated)
  }
  
  func doPasswordMatch(password: String, repeatePassword: String) -> Bool {
    passwordEqualityValidated += 1
    return validate(count: passwordEqualityValidated)
  }
  
  func validate(count: Int) -> Bool {
    return count == MockSignupModelValidator.STATUS_CALL
  }
}
