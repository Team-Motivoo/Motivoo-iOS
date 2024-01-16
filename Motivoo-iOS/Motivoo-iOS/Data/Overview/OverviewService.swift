//
//  OverviewService.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/17/24.
//

import Foundation

import Moya

enum OverviewService {
    case getMission
}

extension OverviewService: BaseTargetType {
    
    var path: String {
        switch self {
        case .getMission:
            return TextLiterals.URL.getMission
        }
    }
    var method: Moya.Method {
        switch self {
        case .getMission:
            return .get
        }
    }
    var task: Moya.Task {
        switch self {
        case .getMission:
            return .requestPlain
        }
    }
}
