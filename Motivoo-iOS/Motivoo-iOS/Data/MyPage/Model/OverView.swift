//
//  OverView.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/12/24.
//

//import Foundation
//
//struct OverView {
//    let date: String
//    let myImage: String
//    let opponentImage: String
//    let myMission: String
//    let opponentMission: String
//    let myStatusBadge: String
//    let opponentStatusBadge: String
//}

import Foundation

// MARK: - DataClass
struct OverView: Codable {
    let userType: String
    let todayMission: TodayMission
    let missionHistory: [MissionHistory]

    enum CodingKeys: String, CodingKey {
        case userType = "user_type"
        case todayMission = "today_mission"
        case missionHistory = "mission_history"
    }
}

// MARK: - MissionHistory
struct MissionHistory: Codable {
    let date, myMission, myImage, myStatusBadge: String
    let opponentMission, opponentImage, opponentStatusBadge: String

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
