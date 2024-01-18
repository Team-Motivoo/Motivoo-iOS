//
//  HomeRequest.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 1/17/24.
//

import Foundation

struct HomeRequest: Codable {
    let myStepCount, opponentStepCount: Int

    enum CodingKeys: String, CodingKey {
        case myStepCount = "my_step_count"
        case opponentStepCount = "opponent_step_count"
    }
}
