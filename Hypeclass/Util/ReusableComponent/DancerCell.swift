//
//  DancerCell.swift
//  Hypeclass
//
//  Created by Minyoung Kim on 2022/07/19.
//

import UIKit

class DancerCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let dancerCellID = "DancerCellID"
    
    // TODO: 추후에 profileImageURL 사용 예정
//    let profileImage = UIView()
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12.0, weight: .ultraLight)
        
        return label
    }()
    
    let classdayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12.0, weight: .ultraLight)
        
        return label
    }()
    
    let navigationImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "greaterthan")
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
        // 프로필 image
        self.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 63).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 63).isActive = true
        profileImage.backgroundColor = .gray
        
        // 이름 label
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 22).isActive = true
        
        // 댄스장르 label
        self.addSubview(genreLabel)
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        genreLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7).isActive = true
        
        // 클래스요일 label
        self.addSubview(classdayLabel)
        classdayLabel.translatesAutoresizingMaskIntoConstraints = false
        classdayLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        classdayLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 2).isActive = true
        
        self.addSubview(navigationImage)
        navigationImage.translatesAutoresizingMaskIntoConstraints = false
        navigationImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        navigationImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
        navigationImage.widthAnchor.constraint(equalToConstant: 9).isActive = true
        navigationImage.heightAnchor.constraint(equalToConstant: 19).isActive = true
    }
}
