//
//  SearchManager.swift
//  Hypeclass
//
//  Created by Hong jeongmin on 2022/07/26.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class SearchManager {
    static let shared = SearchManager()
    
    func requestSearchDancer(queryString query: String) async throws -> [Dancer]? {
        let snapshot = try await Constant.dancerRef.whereField("name", isGreaterThanOrEqualTo: query).getDocuments()
        
        let searchDancer = snapshot.documents.compactMap { document in
            try? document.data(as: Dancer.self)
        }
        
        return searchDancer
    }
    
    func requestSearchStudio(queryString query: String) async throws -> [Studio]? {
        let snapshot = try await Constant.studioRef.whereField("name", isGreaterThanOrEqualTo: query).getDocuments()
        
        let searchStudio =  snapshot.documents.compactMap { document in
            try? document.data(as: Studio.self)
        }
        
        return searchStudio
    }
    
    func requestSearchGenre(queryString query: String) async throws -> [Dancer]? {
        let snapshot = try await Constant.dancerRef.whereField("genres", arrayContains: query).getDocuments()
        
        let searchGenre = snapshot.documents.compactMap { document in
            try? document.data(as: Dancer.self)
        }
        
        return searchGenre
    }
}
