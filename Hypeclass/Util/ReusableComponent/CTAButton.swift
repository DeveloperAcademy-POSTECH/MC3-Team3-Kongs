//
//  CTAButton.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/30.
//

import UIKit

class CTAButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String) {
        super.init(frame: CGRect.zero)
        layer.cornerRadius = 8
        backgroundColor = .accent
        setTitleColor(.black, for: .normal)
        setTitle(title, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 20)
    }
}
