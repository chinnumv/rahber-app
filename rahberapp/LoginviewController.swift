//
//  LoginviewController.swift
//  rahberapp
//
//  Created by Chinnu M V on 27/04/2024.
//

import Foundation
import UIKit
class LoginViewController : UIViewController{
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var userService: UserService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userService = MockUserService()
    }
    
    // MARK: - @IBAction Methods
    
    @IBAction func backPressed(_ sender: Any) {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        if(usernameTextField.text!.isEmpty){
            showAlertview(message: "Please Enter username and password")
        }
        else{
            
            //  checking login details
            if let data = userService?.getUserWithEmail(forEmail: usernameTextField.text!, forPassword: passwordTextField.text!){
                UserDefaults.standard.set(data.email, forKey: "loginEmail")
                UserDefaults.standard.set(data.name, forKey: "loginName")
                UserDefaults.standard.set(data.id, forKey: "userID")
                UserDefaults.standard.set(true, forKey: "isLogin")
                dismiss(animated: true)
                if let navigationController = navigationController {
                    navigationController.popViewController(animated: true)
                }
            } else {  
                showAlertview(message: "Incorrect Username and password")
            }
        }
    }
    
    // This function to show the message
    func showAlertview(message : String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
