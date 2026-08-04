//
//  InfoViewController.swift
//  Navigation
//
//  Created by Никита Морозов on 17.04.2026.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var alertButton = CustomButton(
        title: "Alert",
        titleColor: .red,
        backgroundColor: .clear
    ) { [weak self] in
        self?.alertButtonPressed()
    }
    
    private lazy var backButton = CustomButton(
        title: "Back",
        titleColor: .black,
        backgroundColor: .clear
    ) { [weak self] in
        self?.backButtonPressed()
    }
    
    private lazy var albumLabel: UILabel = {
        let label = UILabel()
        label.text = "Album data"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var loadButton = CustomButton(
        title: "Load",
        titleColor: .black,
        backgroundColor: .clear
    ) { [weak self] in
        self?.loadButtonPressed()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Info"
        view.backgroundColor = .systemGray2
        
        setupUI()
        
    }
    
    private func setupUI() {
        view.addSubview(alertButton)
        view.addSubview(backButton)
        view.addSubview(albumLabel)
        view.addSubview(loadButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            //alertButton
            alertButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            alertButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            alertButton.topAnchor.constraint(equalTo: loadButton.bottomAnchor, constant: 50),
            alertButton.heightAnchor.constraint(equalToConstant: 44),
            
            //backButton
            backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            backButton.topAnchor.constraint(equalTo: alertButton.bottomAnchor, constant: 50),
        
            //albumLabel
            albumLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            albumLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            albumLabel.heightAnchor.constraint(equalToConstant: 200),
            albumLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            //loadButton
            loadButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loadButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            loadButton.topAnchor.constraint(equalTo: albumLabel.bottomAnchor, constant: 100),
            loadButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func alertButtonPressed() {
        let alert = UIAlertController(title: "Alert", message: "Some message", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Action 1", style: .default) { _ in
            print("action 1 pressed")
        }
        let action2 = UIAlertAction(title: "Action 2", style: .default) { _ in
            print("action 2 pressed")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    private func backButtonPressed() {
        dismiss(animated: true)
    }
    
    private func loadButtonPressed() {
        NetworkService.request2_2 { [weak self] album in
            DispatchQueue.main.async {
                guard let album = album else {
                    self?.albumLabel.text = "error load"
                    return
                }
                
                self?.updateUI(with: album)
            }
        }
    }
    
    private func updateUI(with album: Album) {
        let firstTrack = album.volumes.first?.first
        
        albumLabel.text = """
            Album name: \(album.title)
            Artist name: \(album.artists.first?.name ?? "Неизвестен")
            Album year: \(album.year)
            Tracks count: \(album.trackCount)
            Likes count: \(album.likesCount)
            
            First track:
            \(firstTrack?.title ?? "—")
            \(firstTrack?.formattedDuration ?? "—")
            """
        print("""
                Album loaded:
                Name: \(album.title)
                Artist: \(album.artists.first?.name ?? "—")
                Year: \(album.year)
                Tracks count: \(album.trackCount)
                """)
    }
}
