//
//  ViewController.swift
//  Translator
//
//  Created by Mykyta Yarovoi on 20.02.2025.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var pet1Button: UIButton!
    @IBOutlet weak var pet2Button: UIButton!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var clickerButton: UIButton!
    @IBOutlet var themedViews: [UIView]!
    @IBOutlet weak var mainAnimalImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
    }
    
    private func configureUi() {
        let buttonsWithImages: [(UIButton, String)] = [
            (pet1Button, "Pet1"),
            (pet2Button, "Pet2"),
            (microphoneButton, "microphone-2"),
            (translateButton, "Message-2"),
            (clickerButton, "gear")
        ]
        
        buttonsWithImages.forEach { button, imageName in
            getResizedImageFor(button: button, imageName: imageName)
        }
        
        themedViews.forEach { $0.backgroundColor = .themeWhiteForView }
        view.applyGradient()
    }
    
    private func getResizedImageFor(button: UIButton, imageName: String) {
        if let originalImage = UIImage(named: imageName) {
            let resizedImage = originalImage.resized(toWidth: button.bounds.width)
            button.setImage(resizedImage, for: .normal)
        }
    }
    
    //MARK: - IBOutlets
    
    @IBAction func pet1ButtonPressed(_ sender: UIButton) {
        mainAnimalImage.image = UIImage(named: "cat 2")
        pet2Button.imageView?.image = UIImage(named: "Pet2")?.applyBlur(radius: 2)
    }
    
    @IBAction func pet2ButtonPressed(_ sender: UIButton) {
        mainAnimalImage.image = UIImage(named: "dog")
        pet1Button.imageView?.image = UIImage(named: "Pet1")?.applyBlur(radius: 2)
    }
}
