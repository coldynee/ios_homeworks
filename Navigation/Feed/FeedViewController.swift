//
//  FeedViewController.swift
//  Navigation
//
//  Created by Никита Морозов on 17.04.2026.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let feedModel = FeedModel()
    
    private lazy var postButton = {
        let button = CustomButton(
            title: "Open post",
            titleColor: .darkText,
            backgroundColor: .systemBlue,
            cornerRadius: 10,
        ) { [weak self] in
            self?.postButtonPressed()
        }
        
        return button
    }()
    
    private lazy var secondPostButton = {
        let button = CustomButton(
            title: "Open post",
            titleColor: .darkText,
            backgroundColor: .systemCyan,
            cornerRadius: 10,
        ) { [weak self] in
            self?.postButtonPressed()
        }
        
        return button
    }()
    
    private lazy var checkGuessTextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Input to check"
        textField.autocapitalizationType = .none
        
        return textField
    }()
    
    private lazy var checkGuessButton = {
        let button = CustomButton(
            title: "Check",
            titleColor: .black,
            backgroundColor: .clear,
        ) { [weak self] in
            self?.checkGuess()
        }
        return button
    }()
    
    private lazy var guessLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.backgroundColor = .clear
        
        return label
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
        stackView.addArrangedSubview(checkGuessTextField)
        stackView.addArrangedSubview(checkGuessButton)
        stackView.addArrangedSubview(guessLabel)
        
        return stackView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleGuessResult), name: NSNotification.Name("GuessResult"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupUI() {
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
    
    private func postButtonPressed() {
        let postViewController = PostViewController()
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    private func checkGuess() {
        guard let checkWord = checkGuessTextField.text, !checkWord.isEmpty else {
            guessLabel.text = "Input anything"
            guessLabel.textColor = .black
            return
        }
        
        _ = feedModel.check(checkWord)
    }
    @objc private func handleGuessResult(_ notification: NSNotification) {
        guard let isCorrect = notification.userInfo?["isCorrect"] as? Bool else { return }
        
        DispatchQueue.main.async { [weak self] in
            if isCorrect {
                self?.guessLabel.text = "True"
                self?.guessLabel.textColor = .green
            } else {
                self?.guessLabel.text = "False"
                self?.guessLabel.textColor = .red
            }
        }
     }
}
