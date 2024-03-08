//
//  HomePatchMission.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 3/8/24.
//

import Foundation

struct HomePatchMission: Codable {
    let fileName: String
    
    enum CodingKeys: String, CodingKey {
        case fileName = "file_name"
    }
}
