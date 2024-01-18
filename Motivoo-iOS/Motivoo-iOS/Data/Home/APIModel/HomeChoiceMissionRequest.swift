//
//  ChoiceMissionRequest.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 1/17/24.
//

import Foundation

struct HomeChoiceMissionRequest: Codable {
    let missionID: Int

    enum CodingKeys: String, CodingKey {
        case missionID = "mission_id"
    }
}
