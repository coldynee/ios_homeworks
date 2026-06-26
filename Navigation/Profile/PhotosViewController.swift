//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Никита Морозов on 28.04.2026.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    private let imageProcessor = ImageProcessor()
    private var originalImages: [UIImage] = []
    private var processedImages: [UIImage] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.photosCollectionView.reloadData()
            }
        }
    }
    
    private lazy var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Photo Gallery"
        view.backgroundColor = .white
        setupCollectionView()
        loadImages()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        navigationController?.navigationBar.isHidden = false
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            
        navigationController?.navigationBar.isHidden = true
    }
    private func setupCollectionView() {
        view.addSubview(photosCollectionView)
        
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadImages() {
        for name in photos {
            if let image = UIImage(named: name) {
                originalImages.append(image)
            }
        }
        
        processedImages = originalImages
        photosCollectionView.reloadData()
        
        processImagesWithFilter()
        runExperiments()
    }
    
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return processedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        
        guard indexPath.row < processedImages.count else {
            return cell
        }
        
        let image = processedImages[indexPath.row]
        cell.configure(with: image)
        return cell
    }
    
    
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 8
        let width = (collectionView.bounds.width - spacing * 4) / 3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
}

extension PhotosViewController {
    
    private func processImagesWithFilter(
        filter: ColorFilter = .sepia(intensity: 50),
        qos: QualityOfService = .userInitiated
    ) {
        let startTime = CFAbsoluteTimeGetCurrent()
        
        imageProcessor.processImagesOnThread(
            sourceImages: originalImages,
            filter: filter,
            qos: qos,
        ) { [weak self] processedCGImages in
            guard let self = self else { return }
            var newImages: [UIImage] = []
            for cgImage in processedCGImages {
                if let cgImage = cgImage {
                    newImages.append(UIImage(cgImage: cgImage))
                }
            }
            self.processedImages = newImages
            let endTime = CFAbsoluteTimeGetCurrent()
            let duration = endTime - startTime
            print("images count: \(self.originalImages.count), filter: \(filter), qos: \(qos.name), completion time: \(String(format: "%.4f", duration)) sec")
        }
    }
    
    private func runExperiments() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.processImagesWithFilter(filter: .sepia(intensity: 50), qos: .userInteractive)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.processImagesWithFilter(filter: .sepia(intensity: 50), qos: .userInitiated)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            self.processImagesWithFilter(filter: .sepia(intensity: 50), qos: .default)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.processImagesWithFilter(filter: .sepia(intensity: 50), qos: .utility)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
            self.processImagesWithFilter(filter: .sepia(intensity: 50), qos: .background)
        }
    }
    
//    private func setupSubscription() {
//        let publisher = ImagePublisherFacade()
//        self.publisher = publisher
//        publisher.subscribe(self)
//        
//        var userImages: [UIImage] = []
//        
//        for name in photos {
//            if let image = UIImage(named: name) {
//                userImages.append(image)
//            }
//        }
//        
//        publisher.addImagesWithTimer(time: 0.5, repeat: 20, userImages: userImages)
//    }
//    
//    private func removeSubscription() {
//        guard let publisher = publisher else { return }
//        publisher.removeSubscription(for: self)
//        self.publisher = nil
//    }
}

extension QualityOfService {
    var name: String {
        switch self {
        case .userInteractive: return ".userInteractive (высший)"
        case .userInitiated: return ".userInitiated"
        case .default: return ".default"
        case .utility: return ".utility"
        case .background: return ".background (низший)"
        @unknown default: return ".unknown"
        }
    }
}
