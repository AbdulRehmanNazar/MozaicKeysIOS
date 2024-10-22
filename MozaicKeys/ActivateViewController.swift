//
//  ActivateViewController.swift
//  MozaicKeys
//
//  Created by Muhammad  Aqeel on 14/10/2024.
//

import UIKit

class ActivateViewController: UIViewController {
    
    @IBAction func actionActivate(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "DisableViewController")
        initialViewController.modalPresentationStyle = .fullScreen
        self.present(initialViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
