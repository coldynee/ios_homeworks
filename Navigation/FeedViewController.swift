//
//  FeedViewController.swift
//  Navigation
//
//  Created by Никита Морозов on 17.04.2026.
//

import UIKit

class FeedViewController: UIViewController {
    
    let postButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open post", for: .normal)
        button.setTitleColor(.darkText, for: .normal)
        
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        
        view.addSubview(postButton)
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            postButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 20),
            postButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: -20),
            postButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            postButton.heightAnchor.constraint(equalToConstant: 44.0)
        ])
        
        postButton.addTarget(self, action: #selector(postButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func postButtonPressed(_ sender: UIButton) {
        let postViewController = PostViewController()
        postViewController.post = randomPost()
        navigationController?.pushViewController(postViewController, animated: true)
    }

    func randomPost() -> Post {
        let randomNumber = Int.random(in: 0...10)
        return Post(title: "Post №\(randomNumber)")
    }
}
