//
//  UserDefaultManager.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/17/24.
//

import UIKit

class UserDefaultManager {

    static let shared = UserDefaultManager()
    let defaults = UserDefaults.standard

    // isUserLoggedIn
    func saveUserLoggedIn(login: Bool) {
        defaults.set(login, forKey: "isUserLoggedIn")
    }

    func getUserLoggedIn() -> Bool {
        return defaults.bool(forKey: "isUserLoggedIn")
    }

    // isUserMatched
    func saveUserMatcehd(match: Bool) {
        defaults.set(match, forKey: "isUserMatched")
    }

    func getUserMatcehd() -> Bool {
        return defaults.bool(forKey: "isUserMatched")
    }

    // isFinishedOnboarding
    func saveFinishedOnboarding(finished: Bool) {
        defaults.set(finished, forKey: "isFinishedOnboarding")
    }

    func getFinishedOnboarding() -> Bool {
        return defaults.bool(forKey: "isFinishedOnboarding")
    }

    // inviteCode
    func saveInviteCode(inviteCode: String) {
        defaults.set(inviteCode, forKey: "inviteCode")
    }

    func getInviteCode() -> String {
        return defaults.string(forKey: "inviteCode") ?? ""
    }

    // MARK: - 로그아웃, 탈퇴 및 로그인 테스트시 사용

    func removeUserInfo() {
        print("유저가 탈퇴하여 UserDefault 정보를 삭제했습니다.")
        defaults.removeObject(forKey: "isUserLoggedIn")
        defaults.removeObject(forKey: "isUserMatched")
        defaults.removeObject(forKey: "userId")
        defaults.removeObject(forKey: "isFinishedOnboarding")
        defaults.removeObject(forKey: "inviteCode")
        defaults.synchronize()
    }
}
