//
//  HomeMateGoalStepRequest.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 1/20/24.
//

import Foundation

struct HomeMateGoalStepResponse: Codable {
    let opponentGoalStepCount: Int
    
    enum CodingKeys: String, CodingKey {
        case opponentGoalStepCount = "opponent_goal_step_count"
    }
}
