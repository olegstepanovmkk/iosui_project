//
//  LoginViewController.swift
//  Navigation
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let userService: UserService = {
        #if DEBUG
        return TestUserService()
        #else
        return CurrentUserService()
        #endif
    }()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let loginTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Login"
        tf.borderStyle = .roundedRect
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.isUserInteractionEnabled = true
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        tf.isUserInteractionEnabled = true
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        title = "Login"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [loginTextField, passwordTextField, loginButton].forEach { contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Увеличиваем отступ сверху и добавляем высоту contentView
            loginTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 150),
            loginTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            loginTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Важно! Задаём минимальную высоту contentView
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 500)
        ])
    }
    
    @objc private func loginButtonTapped() {
        guard let loginText = loginTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !loginText.isEmpty else {
            showAlert(message: "Введите логин")
            return
        }
        
        guard let user = userService.getUser(login: loginText) else {
            showAlert(message: "Пользователь '\(loginText)' не найден")
            return
        }
        
        let profileVC = ProfileViewController(user: user)
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
