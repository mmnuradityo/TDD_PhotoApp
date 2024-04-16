//
//  SignupPresenter.swift
//  PhotoApp
//
//  Created by Admin on 16/04/24.
//

import Foundation

class SignupPresenter {
  
  private var formModelValidator: SignupModelValidatorProtocol
  private var webService: SignupWebServiceProtocol
  private weak var delegate: SignupViewDelegate?
  
  init(
    formModelValidator: SignupModelValidatorProtocol,
    webService:  SignupWebServiceProtocol,
    delegate: SignupViewDelegate
  ) {
    self.formModelValidator = formModelValidator
    self.webService = webService
    self.delegate = delegate
  }
  
  func processUserSinup(formModel: SignupFormModel) {
    if !formModelValidator.isFirstNameValid(firstName: formModel.firstName) {
      return
    }
    if !formModelValidator.isLastNameValid(lastName: formModel.lastName) {
      return
    }
    if !formModelValidator.isEmailValid(email: formModel.email) {
      return
    }
    if !formModelValidator.isNewPasswordValid(password: formModel.password) {
      return
    }
    if !formModelValidator.doPasswordMatch(password: formModel.password, repeatePassword: formModel.confirmPassword) {
      return
    }
    
    let requestModel = SignupFormRequestModel(
      email: formModel.email,
      password: formModel.password,
      confirmPassword: formModel.confirmPassword,
      firstName: formModel.firstName,
      lastName: formModel.lastName
    )
    
    webService.signup(withForm: requestModel) { [weak self] responseModel, error in
      if let _ = responseModel {
        self?.delegate?.successfulSignup()
      } else if let error = error {
        self?.delegate?.errorHandler(error: error)
      }
    }
  }
  
}
