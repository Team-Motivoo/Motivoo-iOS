//
//  HomeService.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 1/17/24.
//

import UIKit

import Moya

enum HomeService {
    case patchHome(param: HomeRequest)
    case postMission
    case postMissionChoice(param: HomeChoiceMissionRequest)
    case patchMissionImage(param: HomeMissionImageRequest)
    case putimageWithPreSignedURL(url: String, image: UIImage)
}

extension HomeService: BaseTargetType {
    
    var baseURL: URL {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as! String
        switch self {
        case .putimageWithPreSignedURL(let url, let image):
            return URL(string: url) ?? URL(fileURLWithPath: baseURL)
            
        default:
            let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as! String
            return URL(string: baseURL)!
        }
    }
    var path: String {
        switch self {
        case .patchHome:
            return URLs.Home.home
        case .postMission:
            return URLs.Home.mission
        case .postMissionChoice:
            return URLs.Home.missionChoice
        case .patchMissionImage:
            return URLs.Home.missionImage
        case .putimageWithPreSignedURL:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .patchHome:
            return .patch
        case .postMission:
            return .post
        case .postMissionChoice:
            return .post
        case .patchMissionImage:
            return .patch
        case .putimageWithPreSignedURL:
            return .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .patchHome(let param):
            return .requestJSONEncodable(param)
        case .postMission:
            return .requestPlain
        case .postMissionChoice(let param):
            return .requestJSONEncodable(param)
        case .patchMissionImage(let param):
            return .requestJSONEncodable(param)
        case .putimageWithPreSignedURL(_, let image):
            let imageData = image.jpegData(compressionQuality: 0.8) ?? Data()
            return .requestData(imageData)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .putimageWithPreSignedURL:
            return ["Content-Type": "image/jpeg"]
        default:
            return APIConstants.hasTokenHeader
        }
    }
}
