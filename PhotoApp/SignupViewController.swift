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
    
    // compine online when debugs build
//    #if DEBUG
//    if CommandLine.arguments.contains("-skinSurvey") {
//      print("Skin Survey page")
//    }
//    #endif
//
//    #if DEBUG
//    if ProcessInfo.processInfo.arguments.contains("-skinSurvey") {
//      print("Skin Survey page")
//    }
//    #endif
    
    if presenter == nil {
      let signupModelValidator = SignupFromModelValidator()
      
      let signupUrls = ProcessInfo.processInfo.environment["signupUrl"] ?? "SignupConstanats.signupURLString"
      
      let signupWebService = SignupWebService(urlString: signupUrls)
      
      self.presenter = SignupPresenter(
        formModelValidator: signupModelValidator,
        webService: signupWebService,
        delegate: self
      )
    }
    setupDismissKeyboardGesture()
  }
  
  @IBAction func signupButtonTapped(_ sender: Any) {
    let signupFormModel = SignupFormModel(
      email: userEmailTextField.text ?? "",
      firstName: userLastNameTextField.text ?? "",
      lastName: userFirstNameTextField.text ?? "",
      password: userPasswordTextField.text ?? "",
      confirmPassword: userPasswordConfirmationTextField.text ?? ""
    )
    
    presenter?.processUserSinup(formModel: signupFormModel)
  }
  
}

extension SignupViewController: SignupViewDelegate {
  
  func successfulSignup() {
//    self.performSegue(withIdentifier: "moveToDetail", sender: nil)
    
      let alert = UIAlertController(
        title: "Success",
        message: "This signup operation was successful",
        preferredStyle: .alert
      )
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      alert.view.accessibilityIdentifier = "successAlertDialog"
      self.present(alert, animated: true, completion: nil)
  }
  
  func errorHandler(error: SignupError) {
    let alert = UIAlertController(
      title: "Error",
      message: "Yuor request could not be proccessed at this time cause \(error.localizedDescription)",
      preferredStyle: .alert
    )
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    alert.view.accessibilityIdentifier = "errorAlertDialog"
    self.present(alert, animated: true, completion: nil)
  }
  
  private func setupDismissKeyboardGesture() {
    let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_ : )))
    view.addGestureRecognizer(dismissKeyboardTap)
  }
  
  @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
    view.endEditing(true) // resign first responder
  }
}
