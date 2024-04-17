//
//  SignupViewController.swift
//  PhotoApp
//
//  Created by Admin on 16/04/24.
//

import UIKit

class SignupViewController: UIViewController {
  
  @IBOutlet weak var userFirstNameTextField: UITextField!
  @IBOutlet weak var userLastNameTextField: UITextField!
  @IBOutlet weak var userEmailTextField: UITextField!
  @IBOutlet weak var userPasswordTextField: UITextField!
  @IBOutlet weak var userPasswordConfirmationTextField: UITextField!
  @IBOutlet weak var signupButton: UIButton!
  
  var presenter: SignupPresenterProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if presenter == nil {
      let signupModelValidator = SignupFromModelValidator()
      let signupWebService = SignupWebService(urlString: SignupConstanats.signupURLString)
      
      self.presenter = SignupPresenter(
        formModelValidator: signupModelValidator,
        webService: signupWebService,
        delegate: self
      )
    }
  }
  
  @IBAction func signupButtonTapped(_ sender: Any) {
    let signupFormModel = SignupFormModel(
      email: userEmailTextField.text ?? "",
      firstName: userLastNameTextField.text ?? "",
      lastName: userFirstNameTextField.text ?? "",
      password: userPasswordTextField.text ?? "",
      confirmPassword: userPasswordConfirmationTextField.text ?? ""
    )
    
    do {
      try presenter?.processUserSinup(formModel: signupFormModel)
    } catch {
      print(error)
    }
  }
  
}

extension SignupViewController: SignupViewDelegate {
  
  func successfulSignup() {
    print("signup is Success")
  }
  
  func errorHandler(error: SignupError) {
    print("signup is failed: \(error.localizedDescription)")
  }
  
}
