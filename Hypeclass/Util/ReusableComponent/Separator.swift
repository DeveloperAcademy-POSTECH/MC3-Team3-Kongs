//
//  Separator.swift
//  Hypeclass
//
//  Created by Hong jeongmin on 2022/07/16.
//

import UIKit

class Separator: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
