//
//  StudioManager.swift
//  Hypeclass
//
//  Created by Jiyoung Park on 2022/07/26.
//

import Foundation
import FirebaseFirestore

class StudioManager {
    static let shared = StudioManager()
    
    static var myStudios: [Studio]?
    
    static var allStudios: [Studio]?
    
    func createStudio(id: String, name: String, dancers: [String]) {
        let studio = Studio(id: id, name: name, description: "\(name) description", instagramURL: nil, youtubeURL: nil, dancers: dancers, likes: nil)
        do {
            try Constant.studioRef.document("\(name)").setData(from: studio)
        } catch let error {
            print("Error writing studio to Firestore: \(error)")
        }
    }
    
    func requestAllStudios() async throws -> [Studio]? {
        let snapshot = try await Constant.studioRef.getDocuments()
        
        return snapshot.documents.compactMap { document in
            try? document.data(as: Studio.self)
        }
    }
    
    func requestStudiosBy(dancerName name: String) async throws -> [Studio]? {
        let snapshot = try await Constant.studioRef.whereField("dancers", arrayContains: name).getDocuments()
        
        return snapshot.documents.compactMap { document in
            try? document.data(as: Studio.self)
        }
    }
    
    func requestStudiosBy(studioIDs ids: [String]) async throws -> [Studio]? {
        let snapshot = try await Constant.studioRef.whereField("id", in: ids).getDocuments()

        return snapshot.documents.compactMap { document in
            try? document.data(as: Studio.self)
        }
    }
    
    func incrementLikes(studioName name: String) {
        Constant.studioRef.document(name).updateData([
            "likes": FieldValue.increment(Int64(1))
        ])
    }
    
    func decrementLikes(studioName name: String) {
        Constant.studioRef.document(name).updateData([
            "likes": FieldValue.increment(Int64(-1))
        ])
    }
}
