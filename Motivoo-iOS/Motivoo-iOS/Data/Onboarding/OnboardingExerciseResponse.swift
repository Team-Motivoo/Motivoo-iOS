//
//  OnboardingExerciseResponse.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/17/24.
//

import Foundation

struct OnboardingExerciseResponse: Codable {
    let userID: Int
    let inviteCode: String?
    let exerciseLevel: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case inviteCode = "invite_code"
        case exerciseLevel = "exercise_level"
    }
}
