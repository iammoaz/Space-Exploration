//
//  ViewController.swift
//  Alien Life
//
//  Created by Muhammad Moaz on 2/4/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import UIKit

class LandingController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameTextFieldBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(LandingController.keyboardWillShow(_:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LandingController.keyboardWillHide(_:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PageController" {
            guard let name = nameTextField.text, name != "" else { return }
            guard let pageController = segue.destination as? PageController else { return }
            pageController.page = Adventure.story(withName: name)
        }
    }
    
    func keyboardWillShow(_ notification: Notification) {
        guard let info = notification.userInfo, let keyboardFrame = info[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let frame = keyboardFrame.cgRectValue
        nameTextFieldBottomConstraint.constant = frame.size.height + 10
        
        UIView.animate(withDuration: 0.8) { 
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        nameTextFieldBottomConstraint.constant = 80
        
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

extension LandingController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

