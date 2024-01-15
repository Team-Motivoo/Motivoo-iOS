//
//  BaseTargetType.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/15/24.
//

import Foundation
import Moya

protocol BaseTargetType: TargetType{ }

extension BaseTargetType{

    var baseURL: URL {
        let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as! String
        return URL(string: baseURL)!
    }

    var headers: [String : String]? {
        return APIConstants.hasTokenHeader
    }
}
