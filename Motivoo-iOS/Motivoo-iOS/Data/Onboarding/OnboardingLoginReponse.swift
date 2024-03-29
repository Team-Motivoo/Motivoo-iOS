//
//  OnboardingReponse.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/16/24.
//

import Foundation

// MARK: - OnboardingLoginResponse

struct OnboardingLoginResponse: Codable {
    let tokenType, accessToken, refreshToken: String
    let isFinishedOnboarding, isMatched: Bool
    let id, nickname: String
    
    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case isFinishedOnboarding = "is_finished_onboarding"
        case isMatched = "is_matched"
        case id, nickname
    }
}
