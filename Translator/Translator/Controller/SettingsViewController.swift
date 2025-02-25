//
//  SettingsViewController.swift
//  Translator
//
//  Created by Mykyta Yarovoi on 24.02.2025.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: - UI Elements
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var clickerButton: UIButton!
    @IBOutlet var bottomViewLabels: [UILabel]!

    //MARK: - Variables
    
    private let menuItems = ["Rate us",
                             "Share App",
                             "Contact Us",
                             "Restore Purchases",
                             "Privacy Policy",
                             "Terms of Use"]
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
    }
    
    private func configureUi() {
        view.applyGradient()
        setCustomFont()
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")
        tableView.backgroundColor = .clear
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
    }
}

//MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: menuItems[indexPath.row])
        return cell
    }
    
    @IBAction func translateButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Set Custom Font

extension SettingsViewController {
    private func setCustomFont() {
        bottomViewLabels.forEach { label in
            label.font = .konkhmer(size: 12)
        }
    }
}
