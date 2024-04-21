//
//  SignupPresenterProtocol.swift
//  PhotoApp
//
//  Created by Admin on 16/04/24.
//

import Foundation

protocol SignupPresenterProtocol: AnyObject {
  init(
    formModelValidator: SignupModelValidatorProtocol,
    webService:  SignupWebServiceProtocol,
    delegate: SignupViewDelegate
  )
  
  func processUserSinup(formModel: SignupFormModel)
}
