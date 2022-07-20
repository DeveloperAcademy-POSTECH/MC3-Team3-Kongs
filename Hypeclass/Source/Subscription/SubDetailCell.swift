//
//  DancerCell.swift
//  Hypeclass
//
//  Created by Minyoung Kim on 2022/07/19.
//

import UIKit

struct DancerInfo {
    let profileImage: UIView
    let nameLabel: String
    let genreLabel: String
    let classdayLabel: String
}

class DancerCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let dancerCellID = "DancerCellID"
    
    // TODO: 추후에 profileImageURL 사용 예정
    let profileImage = UIView()
    
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
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.background
        configureUI()
    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        self.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 63).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 63).isActive = true
        profileImage.backgroundColor = .gray
        
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 22).isActive = true
        
        self.addSubview(genreLabel)
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        genreLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7).isActive = true
        
        self.addSubview(classdayLabel)
        classdayLabel.translatesAutoresizingMaskIntoConstraints = false
        classdayLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        classdayLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 2).isActive = true
    }
}
