//
//  SignupWebServiceProtocol.swift
//  PhotoApp
//
//  Created by Admin on 16/04/24.
//

import Foundation

protocol SignupWebServiceProtocol {
  func signup(withForm fromModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void)
}
