//
//  UIImageView+.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2023/12/29.
//

import UIKit

import Kingfisher

extension UIImageView {
    func kfSetImage(url : String?) {
        
        guard let url = url else { return }
        
        if let url = URL(string: url) {
            kf.indicatorType = .activity
            kf.setImage(with: url,
                        placeholder: nil,
                        options: [.transition(.fade(1.0))], progressBlock: nil)
        }
    }
    func setPlaceholderText(_ text: String) {
        if self.image == nil {
            let placeholderLabel = UILabel()
            placeholderLabel.text = text
            placeholderLabel.textColor = .gray500
            placeholderLabel.textAlignment = .center
            placeholderLabel.numberOfLines = 2
            addSubview(placeholderLabel)
            placeholderLabel.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
}

