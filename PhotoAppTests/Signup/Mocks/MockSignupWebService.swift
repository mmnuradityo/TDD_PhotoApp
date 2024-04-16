//
//  MockSignupWebService.swift
//  PhotoAppTests
//
//  Created by Admin on 16/04/24.
//

import Foundation
@testable import PhotoApp

class MockSignupWebService: SignupWebServiceProtocol {
  
  var isSignupMethodCalled: Bool = false
  var error: SignupError?
  
  func signup(withForm fromModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void)  {
    isSignupMethodCalled = true
    
    if let error = self.error {
      completionHandler(nil, error)
    } else {
      let responseModel = SignupResponseModel(status: "ok")
      completionHandler(responseModel, nil)
    }
  }
  
}
