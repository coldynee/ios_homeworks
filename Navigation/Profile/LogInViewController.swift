//
//  LogInViewController.swift
//  Navigation
//
//  Created by Никита Морозов on 28.04.2026.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {

    weak var coordinator: ProfileCoordinator?
    private weak var delegate: LoginViewControllerDelegate?
    
    private var user: User?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email or phone"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textField.tintColor = UIColor(named: "CustomColor")
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.translatesAutoresizingMaskIntoConstraints = false
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textField.tintColor = UIColor(named: "CustomColor")
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var logInButton = CustomButton(
            title: "Log in",
            titleColor: .white,
            backgroundColor: .systemBlue,
            cornerRadius: 10,
            
        ) { [weak self] in
            self?.handleLoginButtonTap()
        }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        setupUI()
        setupTargets()
        setupHideKeyboardOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        logInButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        view.addSubview(scrollView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(loginTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(logInButton)
        contentView.addSubview(activityIndicator)
        scrollView.addSubview(contentView)
        setupConstraints()
    }
    
    func configure(delegate: LoginViewControllerDelegate) {
        self.delegate = delegate
    }
    
    private func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            //scrollView
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            //contentView
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            //logoImageView
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            //loginTextField
            loginTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loginTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            
            //passwordTextField
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            //logInButton
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            //activityIndicator
            activityIndicator.centerXAnchor.constraint(equalTo: logInButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: logInButton.centerYAnchor)
                        
        ])
    }
    private func setupTargets() {
        loginTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        updateButtonState(isEnabled: false)
    }
    
    @objc private func textFieldDidChange() {
        let loginTextFieldFilled = !(loginTextField.text?.isEmpty ?? true)
        let passwordTextFieldFilled = !(passwordTextField.text?.isEmpty ?? true)

        updateButtonState(isEnabled: loginTextFieldFilled && passwordTextFieldFilled)
    }
    
    @objc private func updateButtonState(isEnabled: Bool) {
        logInButton.isEnabled = isEnabled
        UIView.animate(withDuration: 0.2) {
            self.logInButton.alpha = isEnabled ? 1.0 : 0.8
        }
    }
    
    private func handleLoginButtonTap() {
        guard let login = loginTextField.text, !login.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Заполните все поля")
            return
        }
        
        logInButton.isEnabled = false
        logInButton.setTitle("", for: .normal)
        activityIndicator.startAnimating()
        
        delegate?.checkCredentials(login: login, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.logInButton.setTitle("Log in", for: .normal)
                self?.logInButton.isEnabled = true
                
                switch result {
                case .success:
                    self?.navigateToProfile()
                    
                case .failure(let error):
                    self?.handleError(error)
                }
            }
        }
    }
    
    private func handleError(_ error: Error) {
        activityIndicator.stopAnimating()
        logInButton.setTitle("Log in", for: .normal)
        logInButton.isEnabled = true
        
        let nsError = error as NSError
        if let loginError = error as? LoginError {
            showAlert(message: loginError.errorDescription)
        } else if nsError.code == AuthErrorCode.wrongPassword.rawValue {
            showAlert(message: "wrong password")
        } else {
            showAlert(message: error.localizedDescription)
        }
    }
        
    private func navigateToProfile() {
        if let currentUser = Auth.auth().currentUser {
            let user = User(
                login: currentUser.email ?? "",
                fullName: currentUser.displayName ?? "User",
                avatar: UIImage(named: "avatar") ?? UIImage(),
                status: "My status"
            )
            coordinator?.showProfile(with: user)
        }
    }
    
    private func showLoginError(error: LoginError) {
        let alert = UIAlertController(title: error.alertTitle, message: error.errorDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    
    private func getUserService() -> UserService {
        #if DEBUG
        return TestUserService()
        #else
        let avatar = UIImage(named: "avatar") ?? UIImage()
        let realUser = User(
            login: "nikita",
            fullName: "Nikita Morozov",
            avatar: avatar,
            status: "My status"
        )
        return CurrentUserService(currentUser: realUser)
        #endif
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func showInvalidLoginAlert() {
        let alert = UIAlertController(
            title: "Ошибка",
            message: "Неверный логин",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        scrollView.contentInset.bottom = keyboardHeight ?? 0.0
    }
    
    @objc private func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(willShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(willHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    private func setupHideKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            if logInButton.isEnabled {
                handleLoginButtonTap()
            }
        }
        return true
    }
}
