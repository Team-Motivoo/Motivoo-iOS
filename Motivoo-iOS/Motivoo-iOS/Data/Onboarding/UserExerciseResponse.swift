//
//  UserExerciseResponse.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/17/24.
//

import Foundation

struct UserExerciseResponse: Codable {
    let isFinishedOnboarding: Bool

    enum CodingKeys: String, CodingKey {
        case isFinishedOnboarding = "is_finished_onboarding"
    }
}
