//
//  AuthManager.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/29.
//

import Foundation
import FirebaseAuth

class AuthManager {
    
    static let shared = AuthManager()
    
    var verificationID: String?
    var userName: String?
    var phoneNumber: String?
    var currentUser: User? { Auth.auth().currentUser }
    var isLogin: Bool { currentUser != nil }
    
    private init() {
        Auth.auth().languageCode = "ko-KR"; // SMS 전송시 한국말 언어 설정 - BCP-47 을 따름
    }
    
    // MARK: - 인증번호 전송 요청
    
    func requestVerificationCode(phoneNumber: String) {
        UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
        let subString = phoneNumber.substring(from: 3, to: 11)
        let globalNumString = "+8210\(subString)"
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(globalNumString, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print("ERROR: \(error.localizedDescription)")
                } else {
                    self.verificationID = verificationID
                    print("DEBUG: success - verify phoneNumber ")
                }
            }
    }
    
    //MARK: - 회원가입
    
    func signInWith(verificationCode: String) async throws -> AuthDataResult? {
        guard let verificationID = self.verificationID else {
            throw AuthError.noVerificationID
        }
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        
        let result = try await Auth.auth().signIn(with: credential)
        // UserDocument 생성 및 전화번호 데이터 저장.
        
        return result
    }
    

    //MARK: - 회원탈퇴
    
    func deleteAccout() async throws {
        guard let currentUser = self.currentUser else {
            throw AuthError.noCurrentUser
        }
        try await currentUser.delete()
    }
}

enum AuthError: Error {
    case noCurrentUser
    case noVerificationID
}
