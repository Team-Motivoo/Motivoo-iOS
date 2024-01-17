//
//  InviteCodeResponse.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/17/24.
//

import Foundation

struct InviteCodeResponse: Codable {
    let userId: Int
    let isMatched: Bool
    let myInviteCode: Bool
    let isFinishedOnboarding: Bool

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case isMatched = "is_matched"
        case myInviteCode = "my_invite_code"
        case isFinishedOnboarding = "is_finished_onboarding"
    }
}
