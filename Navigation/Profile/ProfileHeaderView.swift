//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Никита Морозов on 19.04.2026.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {

    private var statusText: String = ""
    
    private var avatarOriginalFrame = CGRect.zero
    private var avatarBackground: UIView?
    private var returnAvatarButton: UIButton?
    private var avatarCopy: UIImageView?
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        
        let tapAvatar = UITapGestureRecognizer(target: self, action: #selector(avatarTaped))
        imageView.addGestureRecognizer(tapAvatar)
        
        return imageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Thorffin"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray

        return label
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        
        return button
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Input new status"
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = true

        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        setupUI()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }
    
    private func setupUI() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(setStatusButton)
        addSubview(statusTextField)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        // avatarImageView
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.height.width.equalTo(100)
        }
        
        // fullNameLabel
        fullNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(30)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        // statusLabel
        statusLabel.snp.makeConstraints { make in
            make.bottom.equalTo(statusTextField.snp.top).offset(-5)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(30)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        // setStatusButton
        setStatusButton.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        // statusTextField
        statusTextField.snp.makeConstraints { make in
            make.bottom.equalTo(setStatusButton.snp.top).offset(-16)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(30)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
    }
    
    private func setupTargets() {
        setStatusButton.addTarget(self, action: #selector(showStatusButtonTapped), for: .touchUpInside)
        statusTextField.addTarget(self, action: #selector(statusTextFieldChanged), for: .editingChanged)
    }
    
    @objc func showStatusButtonTapped(_ sender: UIButton) {
        if !statusText.isEmpty {
            statusLabel.text = statusText
            setStatusButton.setTitle("Show status", for: .normal)
            statusTextField.text = ""
        }
        print("Current status is - \(statusLabel.text ?? "")")
    }
    
    @objc func statusTextFieldChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
        setStatusButton.setTitle("Set status", for: .normal)
    }
    
    @objc func avatarTaped(_ gesture: UITapGestureRecognizer) {
        guard let window = self.window else { return }
        
        avatarImageView.isUserInteractionEnabled = false
        
        avatarOriginalFrame = avatarImageView.convert(avatarImageView.bounds, to: window)
        
        avatarCopy = UIImageView(image: avatarImageView.image)
        avatarCopy?.frame = avatarOriginalFrame
        avatarCopy?.contentMode = .scaleAspectFill
        avatarCopy?.clipsToBounds = true
        avatarCopy?.layer.borderColor = UIColor.white.cgColor
        avatarCopy?.layer.borderWidth = 3
        avatarCopy?.backgroundColor = .white
        avatarCopy?.layer.cornerRadius = avatarOriginalFrame.width / 2
        
        avatarImageView.isHidden = true
        
        avatarBackground = UIView(frame: window.bounds)
        avatarBackground?.backgroundColor = .black
        avatarBackground?.alpha = 0
        window.addSubview(avatarBackground!)
        
        window.addSubview(avatarCopy!)
        
        returnAvatarButton = UIButton(type: .system)
        returnAvatarButton?.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        returnAvatarButton?.tintColor = .white
        returnAvatarButton?.alpha = 0
        returnAvatarButton?.addTarget(self, action: #selector(returnAvatarToOrigin), for: .touchUpInside)
        returnAvatarButton?.frame = CGRect(x: window.bounds.width - 60, y: 60, width: 44, height: 44)
        window.addSubview(returnAvatarButton!)
        
        let targetSize = window.bounds.width - 32
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.avatarBackground?.alpha = 0.7
            self.avatarCopy?.center = window.center
            self.avatarCopy?.bounds = CGRect(x: 0, y: 0, width: targetSize, height: targetSize)
            self.avatarCopy?.layer.cornerRadius = 0
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseInOut) {
            self.returnAvatarButton?.alpha = 1
        }
    }
    
    @objc private func returnAvatarToOrigin() {
        guard let background = avatarBackground,
              let copy = avatarCopy,
              let button = returnAvatarButton else { return }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            button.alpha = 0
            copy.frame = self.avatarOriginalFrame
            copy.layer.cornerRadius = self.avatarOriginalFrame.width / 2
            background.alpha = 0
        } completion: { _ in
            self.avatarImageView.isHidden = false
            
            copy.removeFromSuperview()
            background.removeFromSuperview()
            button.removeFromSuperview()
            
            self.avatarBackground = nil
            self.avatarCopy = nil
            self.returnAvatarButton = nil
            
            self.avatarImageView.isUserInteractionEnabled = true
        }
    }
}
