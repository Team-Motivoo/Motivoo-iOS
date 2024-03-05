//
//  OnboardingService.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/16/24.
//

import Foundation

import Moya

enum OnboardingService {
    case postLogin(param: OnboardingLoginRequest)
    case postExercise(param: OnboardingExerciseRequest)
    case getExercise
    case patchInviteCode(param: InviteCodeRequest)
    case getMatchingCheck
    case postInviteCode
}

extension OnboardingService: BaseTargetType {
    var path: String {
        switch self {
        case .postLogin:
            return TextLiterals.URLs.postLogin
        case .postExercise:
            return TextLiterals.URLs.postExercise
        case .getExercise:
            return TextLiterals.URLs.getExercise
        case .patchInviteCode:
            return TextLiterals.URLs.patchInviteCode
        case .getMatchingCheck:
            return TextLiterals.URLs.getMatchingCheck
        case .postInviteCode:
            return TextLiterals.URLs.postInviteCode
        }
    }

    var method: Moya.Method {
        switch self {
        case .postLogin, .postExercise, .postInviteCode:
            return .post
        case .getExercise, .getMatchingCheck:
            return .get
        case .patchInviteCode:
            return .patch
        }
    }

    var task: Moya.Task {
        switch self {
        case .postLogin(let param):
            return .requestJSONEncodable(param) // body로 request를 넘기기
        case .postExercise(let param):
            return .requestJSONEncodable(param)
        case .getExercise, .getMatchingCheck, .postInviteCode:
            return .requestPlain
        case .patchInviteCode(let param):
            return .requestJSONEncodable(param)
        }
    }

    var headers: [String : String]? {
        switch self {
        case .postLogin:
            return APIConstants.noTokenHeader
        case .postExercise, .getExercise, .patchInviteCode, .getMatchingCheck, .postInviteCode:
            return APIConstants.hasTokenHeader
        }
    }
}
