//
//  SignupError.swift
//  PhotoApp
//
//  Created by Admin on 13/04/24.
//

import Foundation

enum SignupError: LocalizedError, Equatable {
  
  // MARK: - LocalizedError
  case invalidFirstName
  case invalidLastName
  case invalidEmail
  case invalidPassword
  case invalidConfirmationPassword
  
  // MARK: - RequestError
  case invalidReposnseModel
  case invalidRequsetURLString
  case failedRequest(description: String)
  
  // MARK: - CutomErrorMessage
  var errorDescription: String? {
    switch self {
    case .failedRequest(let description):
      return description
    default:
      return ""
    }
  }
}
