//
//  HomeMissionCheckResponse.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 1/17/24.
//

import Foundation

struct HomeMissionCheckResponse: Codable {
    let imgPresignedURL: String
    let fileName: String

    enum CodingKeys: String, CodingKey {
        case imgPresignedURL = "url"
        case fileName = "file_name"
    }
}
