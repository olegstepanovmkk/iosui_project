//
//  ProfileHeaderView.swift
//  Navigation
//

import UIKit
import SnapKit
import StorageService

final class ProfileHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Visual objects
    let fullNameLabel = UILabel()
    let avatarImageView = UIImageView()
    let statusLabel = UILabel()
    let statusTextField = UITextField()
    let setStatusButton = UIButton()
    let returnAvatarButton = UIButton()
    let avatarBackground = UIView()
    
    private var statusText = "Ready to help"
    private var avatarOriginPoint = CGPoint()
    
    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        statusTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        // Настройка фона аватарки
        avatarBackground.backgroundColor = .lightGray
        avatarBackground.layer.cornerRadius = 70
        avatarBackground.clipsToBounds = true
        
        // Аватарка
        avatarImageView.image = UIImage(systemName: "person.circle.fill")
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 60
        avatarImageView.backgroundColor = .systemGray5
        
        // Кнопка возврата аватарки (если используется анимация)
        returnAvatarButton.setTitle("↩", for: .normal)
        returnAvatarButton.backgroundColor = .systemBlue
        returnAvatarButton.layer.cornerRadius = 15
        returnAvatarButton.isHidden = true
        
        // Имя
        fullNameLabel.text = "Hipster Cat"
        fullNameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        fullNameLabel.textAlignment = .center
        
        // Статус
        statusLabel.text = "Status:"
        statusLabel.font = .systemFont(ofSize: 14, weight: .medium)
        statusLabel.textColor = .secondaryLabel
        
        // Поле ввода статуса
        statusTextField.placeholder = "Waiting for something..."
        statusTextField.borderStyle = .roundedRect
        statusTextField.font = .systemFont(ofSize: 15)
        
        // Кнопка "Set status"
        setStatusButton.setTitle("Set status", for: .normal)
        setStatusButton.backgroundColor = .systemBlue
        setStatusButton.layer.cornerRadius = 8
        setStatusButton.addTarget(self, action: #selector(setStatusButtonTapped), for: .touchUpInside)
        
        [avatarBackground, avatarImageView, returnAvatarButton, fullNameLabel,
         statusLabel, statusTextField, setStatusButton].forEach { addSubview($0) }
    }
    
    // MARK: - SnapKit Constraints
    private func setupConstraints() {
        
        avatarBackground.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(170)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.center.equalTo(avatarBackground)
            make.width.height.equalTo(150)
        }
        
        returnAvatarButton.snp.makeConstraints { make in
            make.bottom.equalTo(avatarBackground).offset(12)
            make.trailing.equalTo(avatarBackground).offset(12)
            make.width.height.equalTo(36)
        }
        
        fullNameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarBackground.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(fullNameLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
        }
        
        statusTextField.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(48)
        }
        
        setStatusButton.snp.makeConstraints { make in
            make.top.equalTo(statusTextField.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(54)
            make.bottom.equalToSuperview().offset(-40)   // ← теперь в одном месте
        }
    }
    // MARK: - Actions
    @objc private func setStatusButtonTapped() {
        if let newStatus = statusTextField.text, !newStatus.isEmpty {
            statusText = newStatus
            // Здесь можно добавить обновление статуса через StorageService при необходимости
        }
    }
}

// MARK: - UITextFieldDelegate
extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
