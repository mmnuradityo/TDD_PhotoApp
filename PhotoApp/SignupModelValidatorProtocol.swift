//
//  SignupModelValidatorProtocol.swift
//  PhotoApp
//
//  Created by Admin on 16/04/24.
//

import Foundation

protocol SignupModelValidatorProtocol {
  func isFirstNameValid(firstName: String) -> Bool
  
  func isLastNameValid(lastName: String) -> Bool
  
  func isEmailValid(email: String) -> Bool
  
  func isNewPasswordValid(password: String) -> Bool
  
  func doPasswordMatch(password: String, repeatePassword: String) -> Bool
}
