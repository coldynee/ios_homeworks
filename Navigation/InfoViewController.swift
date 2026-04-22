//
//  InfoViewController.swift
//  Navigation
//
//  Created by Никита Морозов on 17.04.2026.
//

import UIKit

class InfoViewController: UIViewController {
    
    let alertButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Alert", for: .normal)
        button.setTitleColor(.red, for: .normal)
        
        return button
    }()
    
    let backButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Info"
        view.backgroundColor = .systemGray2
        
        view.addSubview(alertButton)
        alertButton.addTarget(self, action: #selector(alertButtonPressed), for: .touchUpInside)
        
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
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
    
    @objc func alertButtonPressed(_ sender: UIButton) {
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
    @objc func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
