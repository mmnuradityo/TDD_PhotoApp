//
//  MockSignupViewDelegate.swift
//  PhotoAppTests
//
//  Created by Admin on 16/04/24.
//

import Foundation
import XCTest
@testable import PhotoApp

class MockSignupViewDelegate: SignupViewDelegate {
  
  var expectation: XCTestExpectation?
  var successfullSignupCounter = 0
  var errorSignupCounter = 0
  var error: SignupError?
  
  func successfulSignup() {
    successfullSignupCounter += 1
    expectation?.fulfill()
  }
  
  func errorHandler(error: PhotoApp.SignupError) {
    self.error = error
    errorSignupCounter += 1
    expectation?.fulfill()
  }
  
}
