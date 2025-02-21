//
//  ViewController.swift
//  Translator
//
//  Created by Mykyta Yarovoi on 20.02.2025.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var middleStackView: UIStackView!
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var pet1Button: UIButton!
    @IBOutlet weak var pet2Button: UIButton!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var clickerButton: UIButton!
    @IBOutlet var themedViews: [UIView]!
    @IBOutlet weak var mainAnimalImage: UIImageView!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var middleImageView: UIImageView!
    private let audioRecorder = AudioRecorderManager()
    private var recordingStatus = false
    
    private let processingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Process of translation..."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
    }
    
    private func configureUi() {
        let buttonsWithImages: [(UIButton, String)] = [
            (pet1Button, "Pet1"),
            (pet2Button, "Pet2"),
            (translateButton, "Message-2"),
            (clickerButton, "gear")
        ]
        
        middleImageView.image = UIImage(named: "microphone-2")
        
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
    
    private func handleRecordingButtonUi(status: Bool) {
        if status {
            audioRecorder.stopRecording()
            
            // Удаляем старые констрейнты
            middleImageView.constraints.forEach { constraint in
                if constraint.firstAttribute == .width {
                    middleImageView.removeConstraint(constraint)
                }
                if constraint.firstAttribute == .height {
                    middleImageView.removeConstraint(constraint)
                }
            }
            
            middleImageView.translatesAutoresizingMaskIntoConstraints = false

            // Активируем новые констрейнты для кнопки
            NSLayoutConstraint.activate([
                middleImageView.widthAnchor.constraint(equalToConstant: 70),
                middleImageView.heightAnchor.constraint(equalToConstant: 70)
            ])
        
            middleImageView.image = UIImage(named: "microphone-2")

            recordingLabel.text = "Start Speak"
            
            //Добавить анимацию
            topLabel.isHidden = true
            topStackView.isHidden = true
            middleStackView.isHidden = true
            
            view.addSubview(processingLabel)
            
            NSLayoutConstraint.activate([
                processingLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                processingLabel.bottomAnchor.constraint(equalTo: mainAnimalImage.topAnchor, constant: -63)
            ])
            
           
            
            recordingStatus.toggle()
        } else {
            audioRecorder.requestPermission { [unowned self] granted in
                if granted {
                    self.audioRecorder.startRecording()

                    // Удаляем старые констрейнты
                    middleImageView.constraints.forEach { constraint in
                        if constraint.firstAttribute == .width {
                            middleImageView.removeConstraint(constraint)
                        }
                        if constraint.firstAttribute == .height {
                            middleImageView.removeConstraint(constraint)
                        }
                    }
                    
                    middleImageView.translatesAutoresizingMaskIntoConstraints = false

                    // Активируем новые констрейнты для кнопки
                    NSLayoutConstraint.activate([
                        middleImageView.widthAnchor.constraint(equalToConstant: 163),
                        middleImageView.heightAnchor.constraint(equalToConstant: 95)
                    ])
                    
                    let gifImage = UIImage.gifImageWithName("recording")
                    middleImageView.image = gifImage

                    recordingLabel.text = "Recording..."
                    
                    
                    self.recordingStatus.toggle()
                } else {
                    print("DEBUG: Permission not granted")
                }
            }
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
    
    @IBAction func microphoneButtonPressed(_ sender: UIButton) {
        handleRecordingButtonUi(status: recordingStatus)
    }
    
}
