//
//  SignupPresenter.swift
//  PhotoApp
//
//  Created by Admin on 16/04/24.
//

import Foundation

class SignupPresenter: SignupPresenterProtocol {
  
  private var formModelValidator: SignupModelValidatorProtocol
  private var webService: SignupWebServiceProtocol
  private weak var delegate: SignupViewDelegate?
  
  required init(
    formModelValidator: SignupModelValidatorProtocol,
    webService:  SignupWebServiceProtocol,
    delegate: SignupViewDelegate
  ) {
    self.formModelValidator = formModelValidator
    self.webService = webService
    self.delegate = delegate
  }
  
  func processUserSinup(formModel: SignupFormModel) throws {
    if !formModelValidator.isFirstNameValid(firstName: formModel.firstName) {
      throw SignupError.invalidFirstName
    }
    if !formModelValidator.isLastNameValid(lastName: formModel.lastName) {
      throw SignupError.invalidLastName
    }
    if !formModelValidator.isEmailValid(email: formModel.email) {
      throw SignupError.invalidEmail
    }
    if !formModelValidator.isNewPasswordValid(password: formModel.password) {
      throw SignupError.invalidPassword
    }
    if !formModelValidator.doPasswordMatch(password: formModel.password, repeatePassword: formModel.confirmPassword) {
      throw SignupError.invalidConfirmationPassword
    }
    
    let requestModel = SignupFormRequestModel(
      email: formModel.email,
      password: formModel.password,
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
