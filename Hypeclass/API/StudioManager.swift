//
//  StudioManager.swift
//  Hypeclass
//
//  Created by Jiyoung Park on 2022/07/26.
//

import Foundation

class StudioManager {
    static let shared = StudioManager()
    
    func createStudio(id: String, name: String, dancers: [String]) {
        let studio = Studio(id: id, name: name, description: "\(name) description", instagramURL: nil, youtubeURL: nil, dancers: dancers)
        do {
            try Constant.studioRef.document("\(name)").setData(from: studio)
        } catch let error {
            print("Error writing studio to Firestore: \(error)")
        }
    }
    
    func requestStudiosBy(dancerName name: String) async throws -> [Studio]? {
        let snapshot = try await Constant.studioRef.whereField("dancers", arrayContains: name).getDocuments()
        
        return snapshot.documents.compactMap { document in
            try? document.data(as: Studio.self)
        }
    }
}
