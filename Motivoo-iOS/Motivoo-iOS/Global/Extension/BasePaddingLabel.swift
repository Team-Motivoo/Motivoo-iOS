//
//  BasePaddingLabel.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/15/24.
//

import UIKit

final class BasePaddingLabel: UILabel {
    
    private var padding = UIEdgeInsets(top: 3.0, left: 8.0, bottom: 3.0, right: 8.0)
    
    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
        setUI()
    }
    
    private func setUI(){
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
    }
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        
        return contentSize
    }
}
