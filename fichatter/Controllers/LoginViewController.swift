//
//  LoginViewController.swift
//  fichatter
//
//  Created by Paulina Vara on 23/08/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showNavigationBar()
    }
    
    
    @IBAction func loginRequest(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
              guard let self = self else { return }
                if let err = error {
                    self.alertError(message: err.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: K.loginToChatSegue, sender: self)
                }
            }
        } else {
            alertError(message: K.emptyFieldError)
        }
        
    }
    
    func activeTextField (_ textField: UITextField) {
        //To apply border
        textField.layer.borderWidth = 0.25
        textField.layer.borderColor = UIColor.white.cgColor

        //To apply Shadow
        textField.layer.shadowOpacity = 1
        textField.layer.shadowRadius = 8.0
        textField.layer.shadowOffset = CGSize.zero // Use any CGSize
        textField.layer.shadowColor = #colorLiteral(red: 0.9751314521, green: 0.8238908648, blue: 0.3212167323, alpha: 1).cgColor
    }
}

