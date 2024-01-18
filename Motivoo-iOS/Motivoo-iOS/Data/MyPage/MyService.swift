//  MyService.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/16/24.
//

import Foundation

import Moya

enum MyService {
    case getMyInfo
    case getExerciseInfo
    case postLogout
    case deleteLeave
}

extension MyService: BaseTargetType {
    var path: String {
        switch self {
        case .getMyInfo:
            return TextLiterals.URL.getMyInfo
        case .getExerciseInfo:
            return TextLiterals.URL.getExerciseInfo
        case .postLogout:
            return TextLiterals.URL.postLogout
        case .deleteLeave:
            return TextLiterals.URL.deleteLeave
        }
    }
    var method: Moya.Method {
        switch self {
        case .getMyInfo:
            return .get
        case .getExerciseInfo:
            return .get
        case .postLogout:
            return .post
        case .deleteLeave:
            return .delete
        }
    }
    var task: Moya.Task {
        switch self {
            
        case .getMyInfo:
            return .requestPlain
        case .getExerciseInfo:
            return .requestPlain
        case .postLogout:
            return .requestPlain
        case .deleteLeave:
            return .requestPlain
        }
    }
}
