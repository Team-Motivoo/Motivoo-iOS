//
//  TokenManager.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/15/24.
//

import UIKit

class TokenManager {

    static let shared = TokenManager()
    let defaults = UserDefaults.standard

    @discardableResult
    func isTokenExist() -> Bool {
        let token = defaults.string(forKey: "accessToken")
        if token != nil {
            print("🫶 있음")
            return true
        } else {
            print("❌ 없음")
            return false
        }
    }

    func saveToken(token: String) {
        defaults.set(token, forKey: "accessToken")
    }

    func getToken() -> String {
        return defaults.string(forKey: "accessToken") ?? ""
    }

    // MARK: - 로그아웃, 탈퇴 및 로그인 테스트시 사용

    func removeToken() {
        print("토큰을 삭제했습니다")
        defaults.removeObject(forKey: "accessToken")
        defaults.synchronize()
    }
}
