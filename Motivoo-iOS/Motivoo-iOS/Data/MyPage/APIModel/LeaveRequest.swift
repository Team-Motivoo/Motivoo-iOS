//
//  LeaveRequsetl.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/16/24.
//

import Foundation

struct LeaveRequest: Codable {
    let socialPlatform: String

    enum CodingKeys: String, CodingKey {
        case socialPlatform = "social_platform"
    }
}
