//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Никита Морозов on 19.04.2026.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileHeaderView = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray4
        title = "Profile"
        
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileHeaderView)
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        NSLayoutConstraint.activate([
                    profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    profileHeaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        
        //profileHeaderView.frame = view.frame
    }

}
