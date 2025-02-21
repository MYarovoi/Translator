//
//  ResultViewController.swift
//  Translator
//
//  Created by Mykyta Yarovoi on 21.02.2025.
//

import UIKit

class ResultViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
    }
    
    private func configureUi() {
        view.applyGradient()
    }
    
    
    private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        backButtonTapped()
    }
}
