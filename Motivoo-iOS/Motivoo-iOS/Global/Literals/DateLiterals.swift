//
//  DateLiterals.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2024/01/06.
//

import UIKit

enum DateLiterals {
    
    static let calendar = Calendar.current

    static var year: Int {
        return calendar.component(.year, from: Date())
    }

    static var month: Int {
        return calendar.component(.month, from: Date())
    }

    static var day: Int {
        return calendar.component(.day, from: Date())
    }
}
