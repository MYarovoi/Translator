//
//  SettingsViewController.swift
//  Translator
//
//  Created by Mykyta Yarovoi on 24.02.2025.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var clickerButton: UIButton!

    
    private let menuItems = ["Rate us", "Share App", "Contact Us", "Restore Purchases", "Privacy Policy", "Terms of Use"]
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyGradient()
        
        
        // Настройка таблицы
        tableView.dataSource = self  // Устанавливаем dataSource
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")
        
        let buttonsWithImages: [(UIButton, String)] = [
            (translateButton, "Message-2"),
            (clickerButton, "gear")
        ]
        
        buttonsWithImages.forEach { button, imageName in
            getResizedImageFor(button: button, imageName: imageName)
        }
    }
    
    private func getResizedImageFor(button: UIButton, imageName: String) {
        if let originalImage = UIImage(named: imageName) {
            let resizedImage = originalImage.resized(toWidth: button.bounds.width)
            button.setImage(resizedImage, for: .normal)
        }
    }
}


extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    // Настройка ячеек таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        return cell
    }
}

