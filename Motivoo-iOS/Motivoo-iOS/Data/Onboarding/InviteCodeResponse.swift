//
//  InviteCodeResponse.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/17/24.
//

import Foundation

struct InviteCodeResponse: Codable {
    let userId: Int
    let opponentUserId: Int
    let isMatched: Bool

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case opponentUserId = "opponent_user_id"
        case isMatched = "is_matched"
    }
}
