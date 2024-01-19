//
//  HomeMissionImageRequest.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 1/17/24.
//

import Foundation

struct HomeMissionImageRequest: Codable {
    let imgPrefix: String

    enum CodingKeys: String, CodingKey {
        case imgPrefix = "img_prefix"
    }
}
