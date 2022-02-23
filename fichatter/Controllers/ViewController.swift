//
//  ViewController.swift
//  fichatter
//
//  Created by Paulina Vara on 22/08/21.
//

import UIKit
import CLTypingLabel

class ViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: CLTypingLabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginButton.layer.cornerRadius = 34.5
        registerButton.layer.cornerRadius = 34.5
        titleLabel.text = K.appTitle
        titleLabel.charInterval = 0.2
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        hideNavigationBar()
    }

}

extension UIViewController {
    func hideNavigationBar(){
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    func showNavigationBar() {
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
