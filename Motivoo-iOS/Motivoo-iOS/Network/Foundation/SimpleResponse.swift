//
//  ExceptionResponse.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/15/24.
//

import Foundation

struct SimpleResponse: Codable {
    // response body 없는 모델
    let code: Int?
    let message: String?
    let success: String?
    let data: Data?
}

// 400 에러 떳을 때 응답
