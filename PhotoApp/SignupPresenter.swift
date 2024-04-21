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
  
  func processUserSinup(formModel: SignupFormModel) {
    if !formModelValidator.isFirstNameValid(firstName: formModel.firstName) {
      delegate?.errorHandler(error: SignupError.invalidFirstName)
      return
    }
    if !formModelValidator.isLastNameValid(lastName: formModel.lastName) {
      delegate?.errorHandler(error: SignupError.invalidLastName)
      return
    }
    if !formModelValidator.isEmailValid(email: formModel.email) {
      delegate?.errorHandler(error: SignupError.invalidEmail)
      return
    }
    if !formModelValidator.isNewPasswordValid(password: formModel.password) {
      delegate?.errorHandler(error: SignupError.invalidPassword)
      return
    }
    if !formModelValidator.doPasswordMatch(password: formModel.password, repeatePassword: formModel.confirmPassword) {
      delegate?.errorHandler(error: SignupError.invalidConfirmationPassword)
      return
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
