//
//  MockSignupPresenter.swift
//  PhotoAppTests
//
//  Created by Admin on 16/04/24.
//

import Foundation
@testable import PhotoApp

class MockSignupPresenter: SignupPresenterProtocol {
  
  var proccessUserSignupCalled: Bool = false
  
  required init(
    formModelValidator: PhotoApp.SignupModelValidatorProtocol,
    webService: PhotoApp.SignupWebServiceProtocol,
    delegate: PhotoApp.SignupViewDelegate
  ) {
    // TODO:
  }
  
  func processUserSinup(formModel: SignupFormModel) throws {
    proccessUserSignupCalled = true
  }
  
}
