//
//  HeaderView.swift
//  Hypeclass
//
//  Created by Jiyoung Park on 2022/07/30.
//

import UIKit

class HeaderView: UIView {
    
    // MARK: - Properties
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12.0, weight: .ultraLight)
        label.numberOfLines = 2
        
        return label
    }()
    
    private let instagramImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DancerInstagramImage")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private var instagramURL: String?
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init(frame: CGRect, coverImageURL: String?, profileImageURL: String?, title: String?, subtitle: String?, instagramURL: String?) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        subtitleLabel.text = subtitle
        self.instagramURL = instagramURL
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func instaImageTapped() {
        if let url = URL(string: self.instagramURL ?? "https://instagram.com/wootae_______?igshid=YmMyMTA2M2Y=") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        // coverImageView
        self.addSubview(coverImageView)
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        coverImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        coverImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        coverImageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        // profileImageView
        self.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 20).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        // titleLabel
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
        
        // subtitleLabel
        self.addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        
        // instagramImageView
        self.addSubview(instagramImageView)
        instagramImageView.translatesAutoresizingMaskIntoConstraints = false
        instagramImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        instagramImageView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -10).isActive = true
        instagramImageView.heightAnchor.constraint(equalToConstant: 22).isActive = true
        instagramImageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        
        instagramImageView.isUserInteractionEnabled = true
        instagramImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(instaImageTapped)))
    }
}
