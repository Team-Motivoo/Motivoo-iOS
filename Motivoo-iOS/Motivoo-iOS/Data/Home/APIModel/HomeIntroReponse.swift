//
//  HomeIntroReponse.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 1/17/24.
//

import Foundation

struct HomeIntroResponse: Codable {
    let userType: String
    let userID, userGoalStepCount, opponentUserGoalStepCount, opponentUserID: Int
    let isStepCountCompleted, isOpponentUserWithdraw, isMissionImgCompleted: Bool

    enum CodingKeys: String, CodingKey {
        case userType = "user_type"
        case userID = "user_id"
        case userGoalStepCount = "user_goal_step_count"
        case opponentUserID = "opponent_user_id"
        case opponentUserGoalStepCount = "opponent_user_goal_step_count"
        case isStepCountCompleted = "is_step_count_completed"
        case isOpponentUserWithdraw = "is_opponent_user_withdraw"
        case isMissionImgCompleted = "is_mission_img_completed"
    }
}
