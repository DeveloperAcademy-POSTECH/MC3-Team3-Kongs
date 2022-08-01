//
//  MainStudioCell.swift
//  Hypeclass
//
//  Created by Jiyoung Park on 2022/07/29.
//

import UIKit

class MainStudioCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var studioImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true

        return imageView
    }()
    
    let studioNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12.0, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
        
        return label
    }()
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureLayout() {
        // studioImage
        contentView.addSubview(studioImage)
        studioImage.translatesAutoresizingMaskIntoConstraints = false
        studioImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        studioImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        studioImage.widthAnchor.constraint(equalToConstant: 55).isActive = true
        studioImage.heightAnchor.constraint(equalToConstant: 55).isActive = true

        // studioNameLabel
        contentView.addSubview(studioNameLabel)
        studioNameLabel.translatesAutoresizingMaskIntoConstraints = false
        studioNameLabel.numberOfLines = 1
        studioNameLabel.allowsDefaultTighteningForTruncation = true
        studioNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        studioNameLabel.topAnchor.constraint(equalTo: studioImage.bottomAnchor, constant: 2).isActive = true
        studioNameLabel.widthAnchor.constraint(equalToConstant: 55).isActive = true
    }
}
