//
//  PostViewController.swift
//  Navigation
//
//  Created by Никита Морозов on 17.04.2026.
//

import UIKit

class PostViewController: UIViewController {

    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = post?.title ?? "Post"
        
        view.backgroundColor = .systemGray
        
        createBarButtonItem()
    }
    
    func createBarButtonItem() {
        let infoButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(infoButtonPressed))
        navigationItem.rightBarButtonItem = infoButton
    }

    @objc func infoButtonPressed(_ sender: UIBarButtonItem) {
        let infoViewController = InfoViewController()
        infoViewController.modalTransitionStyle = .coverVertical
        infoViewController.modalPresentationStyle = .pageSheet
        present(infoViewController, animated: true)
    }

}
