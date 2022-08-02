//
//  SearchManager.swift
//  Hypeclass
//
//  Created by Hong jeongmin on 2022/07/26.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

enum FirebaseQuery: String {
    case genres
    case name
}

enum FirebaseCategory: String {
    case studio
    case dancer
}

class SearchManager {
    static let shared = SearchManager()
    
    func requestQuery<T: Codable>(queryString query: String, mode: FirebaseQuery, category: FirebaseCategory) async throws -> [T]? {
        var snapshot: QuerySnapshot
        
        switch mode {
        case .name:
            if category == FirebaseCategory.dancer {
                snapshot = try await Constant.dancerRef.whereField(mode.rawValue, isEqualTo: query).getDocuments()
            } else {
                snapshot = try await Constant.studioRef.whereField(mode.rawValue, isEqualTo: query).getDocuments()
            }
        case .genres:
            snapshot = try await Constant.dancerRef.whereField(mode.rawValue, arrayContains: query).getDocuments()
        }
        
        let result = snapshot.documents.compactMap { document in
            try? document.data(as: T.self)
        }
        return result
    }
}
