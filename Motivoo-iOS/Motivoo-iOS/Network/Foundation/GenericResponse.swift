//
//  GenericResponse.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/15/24.
//

import Foundation

struct GenericResponse<T: Codable>: Codable {
    // response Data 디코딩 해주기 위한 모델
    let code: Int?
    let message: String?
    let success: String?
    let data: T?
}
