//
//  SignupFromModelValidator.swift
//  PhotoApp
//
//  Created by Admin on 11/04/24.
//

import Foundation


// MARK: caller
class SignupFromModelValidator {
  
  func isFirstNameValid(firstName: String) -> Bool {
    return isValidLength(text: firstName)
    && isContainWithChararterOnly(text: firstName)
  }
  
  func isLastNameValid(lastName: String) -> Bool {
    return isValidLength(text: lastName)
    && isContainWithChararterOnly(text: lastName)
  }
  
  func isEmailValid(email: String) -> Bool {
    return isContainWithEmailCriteria(text: email)
  }
  
  func isNewPasswordValid(password: String) -> Bool {
    return isValidPasswordLenght(text: password)
    && isValidPassWordCriteria(text: password)
  }
  
  func doPasswordMatch(password: String, repeatePassword: String) -> Bool {
    return password == repeatePassword
  }
  
}

// MARK: logical
extension SignupFromModelValidator {
  private func isValidLength(text: String) -> Bool {
    return text.count > SignupConstanats.inputNameMinLenght
    && text.count <= SignupConstanats.inputNameMaxLenght
  }
  
  private func isContainWithChararterOnly(text: String) -> Bool {
    let isContainCharacter = text.range(
      of: SignupConstanats.chracterPattern, options: .regularExpression
    ) != nil
    
    if isContainCharacter {
      return !isContainWithNumbers(text: text)
      && !isContainWithSpecialCharacters(text: text)
    }
    
    return isContainCharacter
  }
  
  private func isContainWithEmailCriteria(text: String) -> Bool {
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", SignupConstanats.emailRegex)
    return emailPredicate.evaluate(with: text)
  }
  
  private func isValidPasswordLenght(text: String) -> Bool {
    return text.count >= SignupConstanats.passwordMinLenght
  }
  
  private func isValidPassWordCriteria(text: String) -> Bool {
    return isContainWithNumbers(text: text)
    && isContainWithSpecialCharacters(text: text)
    && isContainWithNotValidSpecialCharacters(text: text)
  }
  
  private func isContainWithNumbers(text: String) -> Bool {
    return text.range(of: SignupConstanats.numbersPattern, options: .regularExpression) != nil
  }
  
  private func isContainWithSpecialCharacters(text: String) -> Bool {
    return text.range(of: SignupConstanats.specialCharactersPattern, options: .regularExpression) != nil
  }
  
  private func isContainWithNotValidSpecialCharacters(text: String) -> Bool {
    let invalidSet = CharacterSet(charactersIn: SignupConstanats.validCharacterInput).inverted
    return text.rangeOfCharacter(from: invalidSet) == nil
  }
}
