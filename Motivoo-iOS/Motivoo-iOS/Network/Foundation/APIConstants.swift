//
//  APIConstants.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/15/24.
//

import Foundation
import Moya

struct APIConstants{

    static let contentType = "Content-Type"
    static let applicationJSON = "application/json"
    static let multipartFormData = "multipart/form"
    static let auth = "Authorization"
    static let refresh = "RefreshToken"
    static let accessToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJwYXlsb2FkIjoiMSIsImlhdCI6MTcwNTM0NzAyMywiZXhwIjoxNzA3MTQ3MDIzfQ.NGcZI4lyseER0MTCPAncDUzh_Kgb1IqDT_Da2Qpquk8"
}

extension APIConstants{

    static var noTokenHeader: Dictionary<String,String> {
        [contentType: applicationJSON]
    }

    static var hasTokenHeader: Dictionary<String,String> {
        [contentType: applicationJSON,
               auth : "\(accessToken)"]
    }
}
