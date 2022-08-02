//
//  UIColor.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import UIKit

extension UIColor {
    // MARK: hex code를 이용하여 정의
    // ex. UIColor(hex: 0xF5663F)
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    class var background: UIColor { UIColor(hex: 0x181818) }
    class var accent: UIColor { UIColor(hex: 0xC7FD51) }
    class var container: UIColor{ UIColor(hex: 0x2D2C38) }
    class var primary: UIColor { UIColor(hex: 0x7A7A7A) }
    class var secondary: UIColor { UIColor(hex: 0xE2E2E2) }
    class var touchable: UIColor { UIColor(hex: 0x6D6F79) }
}
