//
//  MyInfoUserResponse.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/17/24.
//

import Foundation


// MARK: - DataClass
struct MyInfoUserResponse: Codable {
    let userNickname: String
    let userAge: Int

    enum CodingKeys: String, CodingKey {
        case userNickname = "user_nickname"
        case userAge = "user_age"
    }
}
