//
//  NewInviteCodeResponse.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 3/4/24.
//

import Foundation

// MARK: - NewInviteCodeResponse
struct NewInviteCodeResponse: Codable {
    let userID: Int
    let isMatched: Bool
    let inviteCode: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case isMatched = "is_matched"
        case inviteCode = "invite_code"
    }
}
