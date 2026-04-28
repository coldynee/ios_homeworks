//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Никита Морозов on 19.04.2026.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var postsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        view.backgroundColor = .systemGray6
        
        setupTableView()
        setupHeaderView()
    }
    
    private func setupTableView() {
        view.addSubview(postsTableView)
        
        NSLayoutConstraint.activate([
            postsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            postsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        postsTableView.delegate = self
        postsTableView.dataSource = self
    }
    
    private func setupHeaderView() {
        let headerView = ProfileHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = true
        
        headerView.frame.size.width = postsTableView.bounds.width
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let size = headerView.systemLayoutSizeFitting(CGSize(width: postsTableView.bounds.width, height: UIView.layoutFittingCompressedSize.height))
        headerView.frame.size.height = size.height
        postsTableView.tableHeaderView = headerView
    
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return posts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as? PhotosTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else {
                return UITableViewCell()
            }
            let post = posts[indexPath.row]
            cell.configure(with: post)
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            let photosViewController = PhotosViewController()
            navigationController?.pushViewController(photosViewController, animated: true)
        }
    }
}
