//
//  Dancer.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/11.
//

import Foundation

struct Dancer: Codable {
    let id: String
    let name: String?
    let lastUpdate: Date?
    let description: String?
    let coverImageURL: String?
    let profileImageURL: String?
//    let tags: [String]
    
    let genres: [String]?
    let studios: [String]?
    let youtubeURL: [String]?
    let instagramURL: String?
}

/*
 추가

 
 삭제
 스케쥴 어레이 삭제
 */
