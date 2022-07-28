//
//  Constant.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/11.
//

import Foundation
import FirebaseFirestore

class Constant {
    static let dancerRef = Firestore.firestore().collection("dancer")
    static let danceClassRef = Firestore.firestore().collection("danceClass")
    static let studioRef = Firestore.firestore().collection("studio")
}
