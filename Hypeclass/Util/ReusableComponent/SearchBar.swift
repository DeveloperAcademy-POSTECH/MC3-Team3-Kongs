//
//  SearchBar.swift
//  Hypeclass
//
//  Created by Hong jeongmin on 2022/07/16.
//

import UIKit

//MARK: - SearchBar Custom

class SearchBar: UISearchBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        
        self.tintColor = .white
        self.searchTextField.font = UIFont.systemFont(ofSize: 12.0)
        self.searchTextField.textColor = .white
        self.searchTextField.backgroundColor = .searchBarBackground
        self.searchTextField.leftViewMode = .never
        self.returnKeyType = .google
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
