//
//  PostTableViewCell.swift
//  Navigation
//

import UIKit
import StorageService
import iOSIntPackage

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Visual objects
    var postAuthor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    var postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray6
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    var postDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(postAuthor)
        contentView.addSubview(postImage)
        contentView.addSubview(postDescription)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            postAuthor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            postAuthor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postAuthor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            postImage.topAnchor.constraint(equalTo: postAuthor.bottomAnchor, constant: 12),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor, multiplier: 0.65),
            
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 12),
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    // MARK: - Configure
    func configure(with post: Post) {
        postAuthor.text = post.author
        postDescription.text = post.description
        
        if let image = UIImage(named: post.image) {
            applyFilterToImage(image)
        } else {
            postImage.image = UIImage(systemName: "photo")
        }
    }
    
    // MARK: - Apply Filter
    private func applyFilterToImage(_ originalImage: UIImage) {
        let processor = ImageProcessor()
        
        processor.processImage(sourceImage: originalImage, filter: .sepia(intensity: 0.8)) { filteredImage in
            DispatchQueue.main.async {
                self.postImage.image = filteredImage
            }
        }
    }
}
