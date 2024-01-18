//
//  HomeMissionRequest.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 1/17/24.
//

import Foundation

// MARK: - DataClass

struct HomeMissionsResponse: Codable {
    let isChoiceFinished: Bool
    let date: String?
    let missionChoiceList: [MissionChoiceList]?
    let todayMission: HomeTodayMissions?

    enum CodingKeys: String, CodingKey {
        case isChoiceFinished = "is_choice_finished"
        case date
        case missionChoiceList = "mission_choice_list"
        case todayMission = "today_mission"
    }
}

// MARK: - MissionChoiceList

struct MissionChoiceList: Codable {
    let missionID: Int
    let missionContent: String
    let missionIconURL: String

    enum CodingKeys: String, CodingKey {
        case missionID = "mission_id"
        case missionContent = "mission_content"
        case missionIconURL = "mission_icon_url"
    }
}

// MARK: - TodayMission

struct HomeTodayMissions: Codable {
    let missionContent: String
    let missionDescription: String
    let missionStepCount: Int
    let missionQuest: String

    enum CodingKeys: String, CodingKey {
        case missionContent = "mission_content"
        case missionDescription = "mission_description"
        case missionStepCount = "mission_step_count"
        case missionQuest = "mission_quest"
    }
}
