//
//  ItemCell.swift
//  Hypeclass
//
//  Created by Jiyoung Park on 2022/07/27.
//

import UIKit

struct ItemInfo {
    let profileImage: UIView
    let title: String
    let subtitle: String
    let detail: String
}

class ItemCell: UITableViewCell {
    
    // MARK: - Properties
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let textView = UIView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12.0, weight: .ultraLight)
        
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12.0, weight: .ultraLight)
        
        return label
    }()
    
    let navigationImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.forward")
        image.tintColor = .white
        
        return image
    }()
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        // profileImage
        self.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 65).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 65).isActive = true
        profileImage.backgroundColor = .gray
        
        // >
        self.addSubview(navigationImage)
        navigationImage.translatesAutoresizingMaskIntoConstraints = false
        navigationImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        navigationImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
        navigationImage.widthAnchor.constraint(equalToConstant: 9).isActive = true
        navigationImage.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        // textView
        self.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        textView.trailingAnchor.constraint(equalTo: navigationImage.trailingAnchor, constant: -20).isActive = true
        
        // Add titleLabel, subtitleLabel, detailLable to textView
        textView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: textView.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor).isActive = true
        
        textView.addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor).isActive = true
        
        textView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        detailLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 2).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor).isActive = true
    }
}

