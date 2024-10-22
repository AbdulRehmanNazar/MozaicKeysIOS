//
//  LoginViewController.swift
//  MozaicKeys
//
//  Created by Muhammad  Aqeel on 14/10/2024.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tfPhone: UITextField!
    
    @IBAction func actionRegister(_ sender: Any) {
        guard let phoneNumber = tfPhone.text, !phoneNumber.isEmpty else {
            showAlert("Please enter your phone number")
            return
        }
        guard phoneNumber.count == 8 else{
            showAlert("Invalid phone number")
            return
        }
        
        let fullPhoneNumber = phoneNumber
        UserDefaults.standard.set(fullPhoneNumber, forKey: "userPhoneNumber")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ActivateViewController")
        initialViewController.modalPresentationStyle = .fullScreen
        self.present(initialViewController, animated: true)
    }
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        tfPhone.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Hide keyboard when "return" key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        return true
    }
    
}

