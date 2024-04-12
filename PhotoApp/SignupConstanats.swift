//
//  SignupConstanats.swift
//  PhotoApp
//
//  Created by Admin on 11/04/24.
//

import Foundation

struct SignupConstanats {
  static let inputNameMinLenght = 2
  static let inputNameMaxLenght = 10
  static let passwordMinLenght = 6
  
  static let chracterPattern = "[a-zA-Z]+"
  static let numbersPattern = "[0-9]+"
  static let specialCharactersPattern = "[~.,@:?!$\\/#*&^%]+"
  static let emailRegex = #"^[a-zA-Z0-9_]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$"#
  
  static let validCharacterInput =  "abcdefghijklmnopqrstuvwxyz"
  + "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  + "0123456789"
  + "~.,@:?!$\\/#*&^%"
}
