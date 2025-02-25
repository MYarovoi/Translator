//
//  CustomTableViewCell.swift
//  Translator
//
//  Created by Mykyta Yarovoi on 24.02.2025.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    //MARK: - UI Elements
    
    private let view: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bulletView: UIView = {
        let view = UIView()
        view.backgroundColor = .themepurpleForMessageView
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.font = .konkhmer(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysOriginal)
        imageView.tintColor = .black
        return imageView
    }()
    
    // MARK: - Cell Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    private func setupViews() {
        contentView.addSubview(view)
        view.addSubview(bulletView)
        bulletView.addSubview(mainLabel)
        bulletView.addSubview(rightImageView)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.heightAnchor.constraint(equalToConstant: 64),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            bulletView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bulletView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bulletView.topAnchor.constraint(equalTo: view.topAnchor),
            bulletView.heightAnchor.constraint(equalToConstant: 50),
            
            mainLabel.leadingAnchor.constraint(equalTo: bulletView.leadingAnchor, constant: 16),
            mainLabel.centerYAnchor.constraint(equalTo: bulletView.centerYAnchor),
            
            rightImageView.centerYAnchor.constraint(equalTo: bulletView.centerYAnchor),
            rightImageView.trailingAnchor.constraint(equalTo: bulletView.trailingAnchor, constant: -13)
        ])
    }
    
    func configure(with text: String) {
        mainLabel.text = text
    }
}
