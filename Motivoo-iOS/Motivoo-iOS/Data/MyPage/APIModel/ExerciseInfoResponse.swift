//
//  ExerciseInfoResponse.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/17/24.
//


import Foundation

// MARK: - DataClass

struct ExerciseInfoResponse: Codable {
    let isExercise: Bool
    let exerciseType, exerciseFrequency, exerciseTime: String
    let healthNotes: [String]

    enum CodingKeys: String, CodingKey {
        case isExercise = "is_exercise"
        case exerciseType = "exercise_type"
        case exerciseFrequency = "exercise_frequency"
        case exerciseTime = "exercise_time"
        case healthNotes = "health_notes"
    }
}
