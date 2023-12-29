//
//  UIView+.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2023/12/29.
//

import UIKit

extension UIView{
    func addSubviews(_ views: UIView...){
        views.forEach { self.addSubview($0) }
    }
}
