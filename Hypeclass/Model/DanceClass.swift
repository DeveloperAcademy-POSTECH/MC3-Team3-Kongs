//
//  DanceClass.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/13.
//

import Foundation

struct DanceClass: Codable {
    let id: String
    let name: String?
    let genres: [String]?
    let description: String?
    let isPopUp: Bool?
    
    // time
    let startTime: Date?
    let endTime: Date?
    
    //dancer
    let dancerID: String?
    let dancerName: String?
    
    //studio
    let studioID: String?
    let studioName: String?
}

/*

 
제거
 
 */
