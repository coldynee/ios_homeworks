//
//  FeedViewController.swift
//  Navigation
//
//  Created by Никита Морозов on 17.04.2026.
//

import UIKit

class FeedViewController: UIViewController {
    
    private lazy var postButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open post", for: .normal)
        button.setTitleColor(.darkText, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(postButtonPressed), for: .touchUpInside)

        return button
    }()
    
    private lazy var secondPostButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open post", for: .normal)
        button.setTitleColor(.darkText, for: .normal)
        button.backgroundColor = .systemCyan
        button.addTarget(self, action: #selector(postButtonPressed), for: .touchUpInside)

        return button
    }()
    
    private lazy var stackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        
        stackView.addArrangedSubview(postButton)
        stackView.addArrangedSubview(secondPostButton)
        
        return stackView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        
        view.addSubview(stackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    @objc func postButtonPressed(_ sender: UIButton) {
        let postViewController = PostViewController()
        postViewController.post = randomPost()
        navigationController?.pushViewController(postViewController, animated: true)
    }

    func randomPost() -> Post {
        let randomNumber = Int.random(in: 1...100)
        return Post(title: "Post №\(randomNumber)")
    }
}
