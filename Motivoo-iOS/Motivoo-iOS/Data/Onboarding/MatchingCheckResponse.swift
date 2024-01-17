//
//  MatchingChechResponse.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/17/24.
//

import Foundation

struct MatchingCheckResponse: Codable {
    let isMatched: Bool
    let userID, opponentUserID: Int

    enum CodingKeys: String, CodingKey {
        case isMatched = "is_matched"
        case userID = "user_id"
        case opponentUserID = "opponent_user_id"
    }
}
