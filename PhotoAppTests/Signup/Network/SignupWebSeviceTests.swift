//
//  SignupWebSeviceTests.swift
//  PhotoAppTests
//
//  Created by Admin on 13/04/24.
//

import XCTest
@testable import PhotoApp

final class SignupWebSeviceTests: XCTestCase {
  
  var sut: SignupWebService!
  var sigupFormRequestModel: SignupFormRequestModel!
  
  override func setUpWithError() throws {
    let config = URLSessionConfiguration.ephemeral
    config.protocolClasses = [MockURLProtocol.self]
    let urlSession = URLSession(configuration: config)
    
    sut = SignupWebService(
      urlString: SignupConstanats.signupURLString, urlSession: urlSession
    )
    sigupFormRequestModel = SignupFormRequestModel(
      email: "email@email.com", password: "Password!23", firstName: "FirstName", lastName: "LastName"
    )
  }
  
  override func tearDownWithError() throws {
    sut = nil
    sigupFormRequestModel = nil
    MockURLProtocol.stubResponseData = nil
    MockURLProtocol.error = nil
  }
  
  func testSignupWebSevice_WhenGivenSuccessfullResponse_ThenShouldReturnSuccess() {
    
    // Arrange
    let jsonString = "{\"status\":\"ok\"}"
    MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
    
    let expectation = self.expectation(description: "Signup Web Service Response Expectation")
    
    // Act
    sut.signup(withForm: sigupFormRequestModel) { (signupResponseModel, error) in
      
      // Assert
      XCTAssertEqual(signupResponseModel?.status, "ok")
      expectation.fulfill()
    }
    
    self.wait(for: [expectation], timeout: 5)
  }
 
  func testSignupWebService_WhenReceivedDiffrentJSONResponse_ErrorTookPlace() {
    
    // Arrange
    let jsonString = "{\"path\":\"/users\", \"error\":\"Internal server error\"}"
    MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
    
    let expectation = self.expectation(description: "Signup() methode Expectation of a response that contains different JSON struckture")
    
    // Act
    sut.signup(withForm: sigupFormRequestModel) { (signupResponseModel, error) in
      
      // Assert
      XCTAssertEqual(
        error, SignupError.invalidReposnseModel,
        "The siginup() methode did not return expected error"
      )
      XCTAssertNil(
        signupResponseModel,
        "The response model for a request containing unknown JSON response, should have been nil"
      )
      expectation.fulfill()
    }
    
    self.wait(for: [expectation], timeout: 5)
  }
  
  func testSignupWebService_WhenEmptyURLStringProvided_ReturnError() {
    // Arrange
    let expectation = self.expectation(description: "An empty request URL string expectation")
    
    sut = SignupWebService(urlString: "")
    
    // Act
    sut.signup(withForm: sigupFormRequestModel) { signupResponseModel, error in
      // Assert
      XCTAssertEqual(
        error, SignupError.invalidRequsetURLString,
        "The signup() methode did not return an expected error for an invalidRequestURLString error"
      )
      XCTAssertNil(
        signupResponseModel,
        "When an invalidRequestURLString takes pleace, the response model must be nil"
      )
      expectation.fulfill()
    }
    
    self.wait(for: [expectation], timeout: 2)
  }
  
  func testSignupWebService_WhenURLRequestFails_ReturnErrorMessageDescription() {
    // Arrange
    let expectation = self.expectation(description: "A failed Request expectation")
    let errorDescription = "A localized description of an error"
    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorDescription])
    MockURLProtocol.error = error
    
    // Act
    sut.signup(withForm: sigupFormRequestModel) { signupResponseModel, error in
      XCTAssertEqual(
        error, SignupError.failedRequest(description: errorDescription),
        "The signup() methode did not return an expecter error for the Failed Request"
      )
      XCTAssertEqual(
        error?.errorDescription, errorDescription,
        "Double check to validate error from call signup() methode"
      )
      XCTAssertNil(
        signupResponseModel,
        "When an invalidRequestURLString takes pleace, the response model must be nil"
      )
      expectation.fulfill()
    }
    
    // Assert
    self.wait(for: [expectation], timeout: 2)
  }
}
