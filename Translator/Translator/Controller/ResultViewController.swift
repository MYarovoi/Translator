//
//  ResultViewController.swift
//  Translator
//
//  Created by Mykyta Yarovoi on 21.02.2025.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var mainAnimalImageView: UIImageView!
    let model = Quotes()
    var mainImageName: UIImage?
    
    var messageBubble: MessageBubbleView!
    
    
    private let repeatButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .themepurpleForMessageView
        button.setTitle("Repeat", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "arrow.trianglehead.clockwise.rotate.90"), for: .normal)
        button.tintColor = .black
        
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.layer.cornerRadius = 16
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 291).isActive = true
        button.heightAnchor.constraint(equalToConstant: 54).isActive = true
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
        
        repeatButton.addTarget(self, action: #selector(repeatButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showRepeatButton()
    }
    
    private func configureUi() {
        if let imageName = mainImageName {
            mainAnimalImageView.image = imageName
        } else {
            mainAnimalImageView.image = UIImage(systemName: "questionmark")
        }
        
        
        messageBubble = MessageBubbleView(quote: model.quote.randomElement() ?? "")
        
        view.applyGradient()
        
        messageBubble.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageBubble)
        
        NSLayoutConstraint.activate([
            messageBubble.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageBubble.bottomAnchor.constraint(equalTo: mainAnimalImageView.topAnchor, constant: -20),
            messageBubble.widthAnchor.constraint(equalToConstant: 291),
            messageBubble.heightAnchor.constraint(equalToConstant: 252)
        ])
    }
    
    
    
    
    func showRepeatButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.messageBubble.isHidden = true
            self.view.addSubview(self.repeatButton)
            NSLayoutConstraint.activate([
                self.repeatButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.repeatButton.bottomAnchor.constraint(equalTo: self.mainAnimalImageView.topAnchor, constant: -125)
            ])
        }
    }
    
    
    
    
    
    
    
    
    private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        backButtonTapped()
    }
    
    @objc func repeatButtonTapped() {
        backButtonTapped()
    }
}
