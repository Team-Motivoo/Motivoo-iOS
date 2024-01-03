//
//  FontLiterals.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2024/01/03.
//

import UIKit

enum AppFontName: String {
    
    case regular = "Pretendard-Regular"
    case medium = "Pretendard-Medium"
    case semiBold = "Pretendard-SemiBold"
    
    var name: String {
        return self.rawValue
    }
}
