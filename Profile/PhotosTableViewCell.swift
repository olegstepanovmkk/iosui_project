//
//  PhotosTableViewCell.swift
//  Navigation
//

import UIKit
import StorageService
import iOSIntPackage

class PhotosTableViewCell: UITableViewCell {
    
    // MARK: Visual objects
    
    var labelPhotos: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Photos"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    var arrowImage: UIImageView = {
        let arrow = UIImageView()
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.image = UIImage(systemName: "arrow.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return arrow
    }()
    
    var stackViewImage: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    
    // MARK: - Init section
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(labelPhotos, arrowImage, stackViewImage)
        
        setupPreviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Previews with Filter
    private func setupPreviews() {
        for ind in 0...2 {
            let imageView = getPreviewImage(index: ind)
            stackViewImage.addArrangedSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(greaterThanOrEqualToConstant: (contentView.frame.width - 24) / 4),
                imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.56),
            ])
        }
    }
    
    func getPreviewImage(index: Int) -> UIImageView {
        let preview = UIImageView()
        preview.translatesAutoresizingMaskIntoConstraints = false
        preview.contentMode = .scaleAspectFill
        preview.layer.cornerRadius = 6
        preview.clipsToBounds = true
        
        var image = Photos.shared.examples[index]
        
        // Применяем фильтр
        let processor = ImageProcessor()
        processor.processImage(sourceImage: image, filter: .sepia(intensity: 0.8)) { filteredImage in
            DispatchQueue.main.async {
                preview.image = filteredImage
            }
        }
        
        return preview
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            labelPhotos.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.indentTwelve),
            labelPhotos.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.indentTwelve),
            labelPhotos.widthAnchor.constraint(equalToConstant: 80),
            labelPhotos.heightAnchor.constraint(equalToConstant: 40),
            
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutConstants.indentTwelve),
            arrowImage.centerYAnchor.constraint(equalTo: labelPhotos.centerYAnchor),
            arrowImage.heightAnchor.constraint(equalToConstant: 40),
            arrowImage.widthAnchor.constraint(equalToConstant: 40),
            
            stackViewImage.topAnchor.constraint(equalTo: labelPhotos.bottomAnchor, constant: LayoutConstants.indentTwelve),
            stackViewImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.indentTwelve),
            stackViewImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutConstants.indentTwelve),
            stackViewImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutConstants.indentTwelve),
        ])
    }
}
