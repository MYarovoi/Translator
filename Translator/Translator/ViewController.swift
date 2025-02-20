//
//  ViewController.swift
//  Translator
//
//  Created by Mykyta Yarovoi on 20.02.2025.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var pet1Button: UIButton!
    @IBOutlet weak var pet2Button: UIButton!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var clickerButton: UIButton!
    @IBOutlet weak var middleLeftView: UIView!
    @IBOutlet weak var rightLeftView: UIView!
    @IBOutlet weak var bottomView: UIView!

        override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
    }
    
    private func configureUi() {
        getGradientLayer()
        getResizedImageFor(button: pet1Button, imageName: "Pet1")
        getResizedImageFor(button: pet2Button, imageName: "Pet2")
        getResizedImageFor(button: microphoneButton, imageName: "microphone-2")
        getResizedImageFor(button: translateButton, imageName: "Message-2")
        getResizedImageFor(button: clickerButton, imageName: "gear")
        
        middleLeftView.backgroundColor = .themeWhiteForView
        rightLeftView.backgroundColor = .themeWhiteForView
        bottomView.backgroundColor = .themeWhiteForView
    }
    
    private func getGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.themeWhiteShade.cgColor, UIColor.themeGreenShade.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func getResizedImageFor(button: UIButton, imageName: String) {
        if let originalImage = UIImage(named: imageName) {
            let resizedImage = originalImage.resized(toWidth: button.bounds.width)
            button.setImage(resizedImage, for: .normal)
        }
    }
    
    //MARK: - Preview
    
    #Preview {
        ViewControllerPreview()
    }
    
    struct ViewControllerPreview: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> ViewController {
            return ViewController()
        }
        
        func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
    }
}
