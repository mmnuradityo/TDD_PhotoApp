//
//  SignupError.swift
//  PhotoApp
//
//  Created by Admin on 13/04/24.
//

import Foundation

enum SignupError: LocalizedError, Equatable {
  case invalidReposnseModel
  case invalidRequsetURLString
  case failedRequest(description: String)
  
  var errorDescription: String? {
    switch self {
    case .failedRequest(let description):
      return description
    case .invalidRequsetURLString, .invalidReposnseModel:
      return ""
    }
  }
}
