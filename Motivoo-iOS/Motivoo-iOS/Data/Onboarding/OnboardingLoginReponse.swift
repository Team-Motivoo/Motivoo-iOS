//
//  OnboardingReponse.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/16/24.
//

import Foundation

// MARK: - OnboardingLoginResponse

struct OnboardingLoginResponse: Codable {
    let tokenType, accessToken, refreshToken, id: String
    let nickname: String

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case id, nickname
    }
}
