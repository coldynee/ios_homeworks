//
//  CustomButton.swift
//  Navigation
//
//  Created by Никита Морозов on 18.06.2026.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    private var action: (() -> Void)?
    
    init(
        title: String,
        titleColor: UIColor = .white,
        backgroundColor: UIColor = .systemBlue,
        cornerRadius: CGFloat = 10,
        font: UIFont = .systemFont(ofSize: 16, weight: .medium),
        action: (() -> Void)? = nil
    ) {
        self.action = action
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        titleLabel?.font = font
        translatesAutoresizingMaskIntoConstraints = false
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        action?()
    }
    
    func setAction(_ action: @escaping () -> Void) {
        self.action = action
    }
}
