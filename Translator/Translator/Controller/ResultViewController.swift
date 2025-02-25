//
//  ResultViewController.swift
//  Translator
//
//  Created by Mykyta Yarovoi on 21.02.2025.
//

import UIKit

class ResultViewController: UIViewController {
    
    //MARK: - UI Elements
    
    @IBOutlet weak var mainAnimalImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    private let repeatButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .themepurpleForMessageView
        button.setTitle("Repeat", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Konkhmer Sleokchher", size: 12)
        button.setImage(UIImage(systemName: "arrow.trianglehead.clockwise.rotate.90"), for: .normal)
        button.tintColor = .black
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 291).isActive = true
        button.heightAnchor.constraint(equalToConstant: 54).isActive = true
        return button
    }()
    
    //MARK: - Variables
    
    private let model = Quotes()
    private var messageBubble: MessageBubbleView!
    var mainImageName: UIImage?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showRepeatButton()
    }
    
    private func configureUi() {
        view.applyGradient()
        setCustomFont()
        
        if let imageName = mainImageName {
            mainAnimalImageView.image = imageName
        } else {
            mainAnimalImageView.image = UIImage(systemName: "questionmark")
        }
        
        messageBubble = MessageBubbleView(quote: model.quote.randomElement() ?? "")
        messageBubble.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageBubble)
        
        NSLayoutConstraint.activate([
            messageBubble.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageBubble.bottomAnchor.constraint(equalTo: mainAnimalImageView.topAnchor, constant: -20),
            messageBubble.widthAnchor.constraint(equalToConstant: 291),
            messageBubble.heightAnchor.constraint(equalToConstant: 252)
        ])
    }
    
    private func showRepeatButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self = self else { return }
            
            self.messageBubble.isHidden = true
            self.view.addSubview(self.repeatButton)
            self.repeatButton.addTarget(self, action: #selector(self.repeatButtonTapped), for: .touchUpInside)
            
            NSLayoutConstraint.activate([
                self.repeatButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.repeatButton.bottomAnchor.constraint(equalTo: self.mainAnimalImageView.topAnchor, constant: -125)
            ])
        }
    }
    
    @objc func repeatButtonTapped() {
        backButtonTapped()
    }
    
    //MARK: - IBActions
    
    @IBAction func backButtonAction(_ sender: Any) {
        backButtonTapped()
    }
    
    private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}


//MARK: - Set Custom Font
extension ResultViewController {
    private func setCustomFont() {
        label.font = UIFont(name: "Konkhmer Sleokchher", size: 32)
    }
}
