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
    let userType, opponentUserType: String
    let todayMission: TodayMission?
    let missionHistory: [MissionHistory?]

    enum CodingKeys: String, CodingKey {
        case userType = "user_type"
        case opponentUserType = "opponent_user_type"
        case todayMission = "today_mission"
        case missionHistory = "mission_history"
    }
}

// MARK: - MissionHistory
struct MissionHistory: Codable {
    let myMissionContent: String?
    let myMissionImgURL: String?
    let myMissionStatus, opponentMissionContent: String?
    let opponentMissionImgURL: String?
    let opponentMissionStatus, date: String?

    enum CodingKeys: String, CodingKey {
        case myMissionContent = "my_mission_content"
        case myMissionImgURL = "my_mission_img_url"
        case myMissionStatus = "my_mission_status"
        case opponentMissionContent = "opponent_mission_content"
        case opponentMissionImgURL = "opponent_mission_img_url"
        case opponentMissionStatus = "opponent_mission_status"
        case date
    }
}

// MARK: - TodayMission
struct TodayMission: Codable {
    let missionContent, date: String?

    enum CodingKeys: String, CodingKey {
        case missionContent = "mission_content"
        case date
    }
}
