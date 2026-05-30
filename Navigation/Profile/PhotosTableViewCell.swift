//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Никита Морозов on 28.04.2026.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    static var identifier: String { "\(Self.self)" }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.right")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let photosContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupPhotos()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(photosContainer)
        
        NSLayoutConstraint.activate([
            //title label
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            //arrowImageView
            arrowImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20),
            //photosContainer
            photosContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            photosContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            photosContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            photosContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            photosContainer.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupPhotos() {
        for i in 0...3 {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "\(photos[i])")
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 6
            photosContainer.addArrangedSubview(imageView)
        }
    }
}
