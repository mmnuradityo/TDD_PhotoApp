//
//  MockSignupPresenter.swift
//  PhotoAppTests
//
//  Created by Admin on 16/04/24.
//

import Foundation
@testable import PhotoApp
import XCTest

class MockSignupPresenter: SignupPresenterProtocol {
  
  var proccessUserSignupCalled: Bool = false
  var error: SignupError?
  var delegate: SignupViewDelegate?
  var expectation: XCTestExpectation?
  
  required init(
    formModelValidator: PhotoApp.SignupModelValidatorProtocol,
    webService: PhotoApp.SignupWebServiceProtocol,
    delegate: PhotoApp.SignupViewDelegate
  ) {
    self.delegate = delegate
  }
  
  func processUserSinup(formModel: SignupFormModel) {
    proccessUserSignupCalled = true
    
    if let error = error {
      delegate?.errorHandler(error: error)
    } else {
      delegate?.successfulSignup()
    }
    expectation?.fulfill()
  }
  
}
