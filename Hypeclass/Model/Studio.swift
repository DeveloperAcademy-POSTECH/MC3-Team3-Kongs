//
//  Studio.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/13.
//

import Foundation

struct Studio: Codable {
    let id: String
    let name: String?
    let description: String?
    let instagramURL: String?
    let youtubeURL: String?
    let dancers: [String]?
}
