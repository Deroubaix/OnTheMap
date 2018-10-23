//
//  ViewController.swift
//  OnTheMap
//
//  Created by Marisha Deroubaix on 19/10/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loading: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    emailTextField.delegate = self
    passwordTextField.delegate = self
    loading.isHidden = true
  }
  
  @IBAction func signUp(_ sender: Any) {
    let signUpURL = URL(string: "https://auth.udacity.com/sign-up")
    UIApplication.shared.open(signUpURL!, options: [:], completionHandler: nil)
  }
  
  @IBAction func login(_ sender: Any) {
    
    loading.isHidden = false
    let errorMessage = checkFields()
    if errorMessage.isEmpty {
      UdacityClient.sharedInstance.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? ""){ [unowned self] (response, error) in
        if let response = response {
          UserInfo.sharedInstance.sessionId = response.sessionID
          UserInfo.sharedInstance.userId = response.userID
          self.retrieveUserInformation(response.userID)
        } else {
          self.showLoginError(error)
        }
        
      }
    } else {
      presentErrorAlertController(title: "Required field", errorMessage: errorMessage, buttonText: "Ok")
    }
  }
  
  //MARK: Private methods
  
  private func retrieveUserInformation(_ userId: String) {
    UdacityClient.sharedInstance.retrieveUserInformation(userId)
    { [unowned self] (response, error) in
      if let response = response {
        UserInfo.sharedInstance.firstName = response.firstName
        UserInfo.sharedInstance.lastName = response.lastName
        performUIUpdatesOnMain {
          self.loading.isHidden = true
          self.performSegue(withIdentifier: "GoToMapTab", sender: nil)
        }
      } else {
        self.showLoginError(error)
      }
    }
  }
  
  private func showLoginError(_ error: NSError?) {
    performUIUpdatesOnMain {
      self.loading.isHidden = true
      let errorText : String
      if let error = error {
        errorText = error.localizedDescription
      } else {
        errorText = "There was an error trying to log in"
      }
      self.presentErrorAlertController(title: "Error", errorMessage: errorText, buttonText: "Ok")
    }
  }
  

  private func checkFields() -> String {
    let email = emailTextField.text
    let password = passwordTextField.text
    var result: String?
    if (email?.isEmpty)! {
      result = "Username required"
    } else if (password?.isEmpty)! {
      result = "Password required"
    }
    return result ?? ""
  }
  
  func presentErrorAlertController(title: String, errorMessage: String, buttonText: String) {
    let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: buttonText, style: .default, handler: nil)
    alert.addAction(alertAction)
    self.present(alert, animated: true, completion: nil)
  }
  
}


extension LoginViewController : UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  

  
}


