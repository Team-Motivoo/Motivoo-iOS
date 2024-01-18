//
//  OverviewResponse.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/17/24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let overviewResponse = try? JSONDecoder().decode(OverviewResponse.self, from: jsonData)

// MARK: - DataClass
import Foundation

// MARK: - DataClass

struct OverViewResponse: Codable {
    let userType: String
    let todayMission: TodayMission?
    let missionHistory: [MissionHistory]?

    enum CodingKeys: String, CodingKey {
        case userType = "user_type"
        case todayMission = "today_mission"
        case missionHistory = "mission_history"
    }
}

// MARK: - MissionHistory

struct MissionHistory: Codable {
    let date, myMission, myStatusBadge: String
    let opponentMission, opponentStatusBadge: String
    let myImage, opponentImage: String?

    enum CodingKeys: String, CodingKey {
        case date
        case myMission = "my_mission_content"
        case myImage = "my_mission_img_url"
        case myStatusBadge = "my_mission_status"
        case opponentMission = "opponent_mission_content"
        case opponentImage = "opponent_mission_img_url"
        case opponentStatusBadge = "opponent_mission_status"
    }
}

// MARK: - TodayMission

struct TodayMission: Codable {
    let missionContent: String

    enum CodingKeys: String, CodingKey {
        case missionContent = "mission_content"
    }
}
