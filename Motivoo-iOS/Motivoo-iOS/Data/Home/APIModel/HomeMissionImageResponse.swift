//
//  HomeMissionImageResponse.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 1/18/24.
//

import Foundation

// MARK: - DataClass

struct HomeMissionImageResponse: Codable {
    let imgPresignedURL: String
    let fileName: String

    enum CodingKeys: String, CodingKey {
        case imgPresignedURL = "img_presigned_url"
        case fileName = "file_name"
    }
}
