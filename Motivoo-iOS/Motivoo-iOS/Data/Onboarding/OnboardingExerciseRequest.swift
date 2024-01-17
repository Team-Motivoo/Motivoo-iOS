//
//  OnboardingExerciseRequest.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/17/24.
//

import Foundation

// MARK: - OnboardingExerciseRequest
struct OnboardingExerciseRequest: Codable {
    let type: String
    let age: Int
    let isExercise: Bool
    let exerciseType, exerciseCount, exerciseTime: String
    let exerciseNote: [String]

    enum CodingKeys: String, CodingKey {
        case type, age
        case isExercise = "is_exercise"
        case exerciseType = "exercise_type"
        case exerciseCount = "exercise_count"
        case exerciseTime = "exercise_time"
        case exerciseNote = "exercise_note"
    }
}
