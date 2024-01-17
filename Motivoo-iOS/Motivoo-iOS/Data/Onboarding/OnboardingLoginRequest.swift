//
//  OnboardingLoginRequest.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/16/24.
//

struct OnboardingLoginRequest: Codable {
    let socialAccessToken, tokenType: String

    enum CodingKeys: String, CodingKey {
        case socialAccessToken = "social_access_token"
        case tokenType = "token_type"
    }
}
