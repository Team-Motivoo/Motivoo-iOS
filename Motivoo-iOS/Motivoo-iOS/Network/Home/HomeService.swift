//
//  HomeService.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 1/17/24.
//

import UIKit

import Moya

enum HomeService {
    case getHome
    case postMission
    case postMissionChoice(param: HomeChoiceMissionRequest)
    case getMissionImage
    case postMateGoalStep
    case putImageWithPreSignedURL(url: String, image: UIImage)
    case patchMissionImage(fileName: String)
}

extension HomeService: BaseTargetType {
    
    var baseURL: URL {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as! String
        switch self {
        case .putImageWithPreSignedURL(let url, let image):
            return URL(string: url) ?? URL(fileURLWithPath: baseURL)
            
        default:
            let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as! String
            return URL(string: baseURL)!
        }
    }
    var path: String {
        switch self {
        case .getHome:
            return URLs.Home.home
        case .postMission:
            return URLs.Home.mission
        case .postMissionChoice:
            return URLs.Home.missionChoice
        case .getMissionImage:
            return URLs.Home.missionImage
        case .putImageWithPreSignedURL:
            return ""
        case .postMateGoalStep:
            return URLs.Home.mateGoalStep
        case .patchMissionImage(fileName: let fileName):
            return URLs.Home.patchMissionImage
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getHome:
            return .get
        case .postMission:
            return .post
        case .postMissionChoice:
            return .post
        case .getMissionImage:
            return .get
        case .putImageWithPreSignedURL:
            return .put
        case .postMateGoalStep:
            return .get
        case .patchMissionImage:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getHome:
            return .requestPlain
        case .postMission:
            return .requestPlain
        case .postMissionChoice(let param):
            return .requestJSONEncodable(param)
        case .getMissionImage:
            return .requestPlain
        case .putImageWithPreSignedURL(_, let image):
            let imageData = image.jpegData(compressionQuality: 0.8) ?? Data()
            return .requestData(imageData)
        case .postMateGoalStep:
            return .requestPlain
        case .patchMissionImage(fileName: let fileName):
            let data = HomePatchMission(fileName: fileName)
            return .requestJSONEncodable(data)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getMissionImage:
            return APIConstants.noTokenHeader
        case .putImageWithPreSignedURL:
            return ["Content-Type": "image/jpeg"]
        default:
            return APIConstants.hasTokenHeader
        }
    }
}
