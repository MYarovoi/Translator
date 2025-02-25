//
//  ViewController.swift
//  Translator
//
//  Created by Mykyta Yarovoi on 20.02.2025.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - UI Elements
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var middleStackView: UIStackView!
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var pet1Button: UIButton!
    @IBOutlet weak var pet2Button: UIButton!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var clickerButton: UIButton!
    @IBOutlet var bottomViewLabels: [UILabel]!
    @IBOutlet var themedViews: [UIView]!
    @IBOutlet weak var mainAnimalImage: UIImageView!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var middleImageView: UIImageView!
    @IBOutlet weak var language1Label: UILabel!
    @IBOutlet weak var language2Label: UILabel!
    private let processingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Process of translation..."
        label.font = .konkhmer(size: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Variables
    
    private let audioRecorder = AudioRecorderManager()
    private var recordingState: RecordingState = .idle
    private enum RecordingState {
        case idle
        case recording
        case processing
    }
    private enum SelectedPet {
        case pet1
        case pet2
    }
    private var selectedPet: SelectedPet = .pet1
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
    }
    
    private func configureUi() {
        view.applyGradient()
        setCustomFont()
        themedViews.forEach { $0.backgroundColor = .themeWhiteForView }
        updateAnimalImages(for: selectedPet)
    }
    
    private func updateAnimalImages(for selectedPet: SelectedPet) {
        switch selectedPet {
        case .pet1:
            mainAnimalImage.image = UIImage(named: "cat 2")
            pet2Button.setImage(UIImage(named: "Pet 2"), for: .normal)
            pet2Button.alpha = 0.4
            pet1Button.alpha = 1
        case .pet2:
            mainAnimalImage.image = UIImage(named: "dog")
            pet1Button.setImage(UIImage(named: "Pet1"), for: .normal)
            pet1Button.alpha = 0.4
            pet2Button.alpha = 1
        }
    }
        
    private func updateUIForIdleState() {
        middleImageView.constraints.forEach { constraint in
            if constraint.firstAttribute == .width || constraint.firstAttribute == .height {
                middleImageView.removeConstraint(constraint)
            }
        }
        
        middleImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            middleImageView.widthAnchor.constraint(equalToConstant: 70),
            middleImageView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        middleImageView.image = UIImage(named: "microphone-2")
        recordingLabel.text = "Start Speak"
        
        topLabel.isHidden = false
        topStackView.isHidden = false
        middleStackView.isHidden = false
        processingLabel.isHidden = true
    }
    
    private func updateUIForRecordingState() {
        audioRecorder.startRecording()
        
        middleImageView.constraints.forEach { constraint in
            if constraint.firstAttribute == .width || constraint.firstAttribute == .height {
                middleImageView.removeConstraint(constraint)
            }
        }
        
        middleImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            middleImageView.widthAnchor.constraint(equalToConstant: 163),
            middleImageView.heightAnchor.constraint(equalToConstant: 95)
        ])
        
        let gifImage = UIImage.gifImageWithName("recording")
        middleImageView.image = gifImage
        recordingLabel.text = "Recording..."
    }
    
    private func showProcessingUI() {
        audioRecorder.stopRecording()
        
        topLabel.isHidden = true
        topStackView.isHidden = true
        middleStackView.isHidden = true
        processingLabel.isHidden = false
        
        view.addSubview(processingLabel)
        NSLayoutConstraint.activate([
            processingLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            processingLabel.bottomAnchor.constraint(equalTo: mainAnimalImage.topAnchor, constant: -63)
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            
            self.recordingState = .idle
            self.updateUIForIdleState()
            self.audioRecorder.deleteRecording()
            
            if let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "Result") as? ResultViewController {
                resultVC.mainImageName = self.mainAnimalImage.image
                resultVC.modalPresentationStyle = .fullScreen
                self.present(resultVC, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - IBAction
    
    @IBAction func changeLanguageButtonPressed(_ sender: UIButton) {
        let temporarylabel = language1Label.text
        language1Label.text = language2Label.text
        language2Label.text = temporarylabel
    }
    
    @IBAction func pet1ButtonPressed(_ sender: UIButton) {
        selectedPet = .pet1
        updateAnimalImages(for: selectedPet)
    }
    
    @IBAction func pet2ButtonPressed(_ sender: UIButton) {
        selectedPet = .pet2
        updateAnimalImages(for: selectedPet)
    }
    
    @IBAction func microphoneButtonPressed(_ sender: UIButton) {
        switch recordingState {
        case .idle:
            recordingState = .recording
            updateUIForRecordingState()
            
        case .recording:
            recordingState = .processing
            showProcessingUI()
            
        case .processing:
            recordingState = .idle
            updateUIForIdleState()
        }
    }
    
    @IBAction func clickerButtonPressed(_ sender: UIButton) {
        if let settingsVC = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") {
            settingsVC.modalPresentationStyle = .fullScreen
            present(settingsVC, animated: true, completion: nil)
        }
    }
}
    
    //MARK: - Set Custom Font
    
extension MainViewController {
    private func setCustomFont() {
        topLabel.font = .konkhmer(size: 32)
        recordingLabel.font = .konkhmer(size: 16)
        language1Label.font = .konkhmer(size: 16)
        language2Label.font = .konkhmer(size: 16)
        
        bottomViewLabels.forEach { label in
            label.font = .konkhmer(size: 12)
        }
    }
}
