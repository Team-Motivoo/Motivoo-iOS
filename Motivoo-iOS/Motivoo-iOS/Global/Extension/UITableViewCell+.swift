//
//  UITableViewCell+.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2023/12/29.
//

import UIKit

extension UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}
