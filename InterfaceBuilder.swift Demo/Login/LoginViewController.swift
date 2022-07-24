//
//  LoginViewController.swift
//  InterfaceBuilder.swift Demo
//
//  Created by Maximilian Mackh on 24.07.22.
//

import UIKit
import BaseComponents

class LoginViewController: UIViewController {
    let emailTextField: UITextField = {
        let textField: UITextField = UITextField(placeholder: "john@appleseed.com")
        textField.keyboardType = .emailAddress
        return textField
    }()
    let passwordTextField: UITextField = {
        let textField: UITextField = UITextField(placeholder: "•••••••")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.color(.background, .systemBackground)

        view.build { [unowned self] in
            VSplit {
                VScroll {
                    Padding(-44)
                    Fixed(80) {
                        UIImageView(symbol: "lock").mode(.scaleAspectFit)
                    }
                    Padding(15)
                    Automatic {
                        UILabel("Email".uppercased()).size(.footnote, .bold)
                    }
                    Fixed(54) {
                        self.emailTextField
                    }
                    Separator()
                    Padding(15)
                    Automatic {
                        UILabel("Password".uppercased()).size(.footnote, .bold)
                    }
                    Fixed(54) {
                        self.passwordTextField
                    }
                    Separator()
                    Padding(15)
                    Fixed(54) {
                        UIButton("Login to Service").color(.text, .white).cornerRadius(8).color(.background, .systemBlue).size(.body, .bold).addAction(for: .touchUpInside) { button in
                            
                            self.view.endEditing(true)
                            
                            self.navigationController?.view.showProgressView(true, type: .appleStyle)
                            
                            print("Login")
                            
                            DispatchQueue.main.async(after: 0.5) {
                                self.navigationController?.view.showProgressView(false)
                                
                                NotificationView.show(.error, in: self.navigationController?.view, for: 2, message: "Check Internet connection")
                            }
                        }
                    }
                } modifier: { scrollingView in
                    scrollingView.edgeInsets = .init(padding: 15)
                    scrollingView.automaticallyAdjustsLayoutMarginInsets = true
                }
            } modifier: { splitView in
                splitView.preventAnimations = true
                
                KeyboardManager.manage(rootView: self.view, resizableChildSplitView: splitView)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.emailTextField.becomeFirstResponder()
    }
}
