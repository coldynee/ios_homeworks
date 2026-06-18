//
//  InfoViewController.swift
//  Navigation
//
//  Created by Никита Морозов on 17.04.2026.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var alertButton = {
        let button = CustomButton(
            title: "Alert",
            titleColor: .red,
            backgroundColor: .clear
        ) { [weak self] in
            self?.alertButtonPressed()
        }
        return button
    }()
    
    private lazy var backButton = {
        let button = CustomButton(
            title: "Back",
            titleColor: .black,
            backgroundColor: .clear
        ) { [weak self] in
            self?.backButtonPressed()
        }
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Info"
        view.backgroundColor = .systemGray2
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(alertButton)
        view.addSubview(backButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            //alertButton
            alertButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            alertButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            alertButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            alertButton.heightAnchor.constraint(equalToConstant: 44),
            
            //backButton
            backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            backButton.topAnchor.constraint(equalTo: alertButton.bottomAnchor, constant: 100)
        
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
}
