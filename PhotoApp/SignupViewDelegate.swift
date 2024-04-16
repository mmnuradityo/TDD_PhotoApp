//
//  SignupViewDelegate.swift
//  PhotoApp
//
//  Created by Admin on 16/04/24.
//

import Foundation

protocol SignupViewDelegate: AnyObject {
  func successfulSignup()
  func errorHandler(error: SignupError)
}
