//
//  WelcomeViewController.swift
//  Market
//
//  Created by Aleksandar Savić on 16.06.20.
//  Copyright © 2020 Aleksandar Savić. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    //MARK: IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var resendButtonOutlet: UIButton!
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //MARK: IBActions
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        print("cancel")
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        print("login")
    }
    @IBAction func registerButtonPressed(_ sender: Any) {
        print("Register")
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        print("forgot")
    }
    @IBAction func resendEmailButtonPressed(_ sender: Any) {
        print("resend")
    }
}
