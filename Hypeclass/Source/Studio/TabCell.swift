//
//  TabCell.swift
//  Hypeclass
//
//  Created by Jiyoung Park on 2022/07/30.
//

import UIKit

class TabCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let tabNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
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
        // tabNameLabel
        contentView.addSubview(tabNameLabel)
        tabNameLabel.translatesAutoresizingMaskIntoConstraints = false
        tabNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        tabNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}
