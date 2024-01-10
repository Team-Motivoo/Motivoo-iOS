//
//  UIBezierPath+.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2024/01/10.
//

import UIKit

extension UIBezierPath {
    static func point(atPercent percent: CGFloat, withRadius radius: CGFloat, andCenter center: CGPoint) -> CGPoint {
        let angle = 2 * CGFloat.pi * percent - CGFloat.pi / 2
        let x = center.x + radius * cos(angle)
        let y = center.y + radius * sin(angle)
        return CGPoint(x: x, y: y)
    }
}
