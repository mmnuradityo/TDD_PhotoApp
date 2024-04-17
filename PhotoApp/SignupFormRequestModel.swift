//
//  SignupFormRequestModel.swift
//  PhotoApp
//
//  Created by Admin on 13/04/24.
//

import Foundation

struct SignupFormRequestModel: Encodable {
  let email: String
  let password: String
  let firstName: String
  let lastName: String
}
