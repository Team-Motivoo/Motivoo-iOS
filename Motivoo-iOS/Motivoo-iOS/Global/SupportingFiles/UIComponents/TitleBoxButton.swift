//
//  TitleBoxButton.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/9/24.
//

import UIKit

class TitleBoxButton: UIButton {

    override var isSelected: Bool {
        didSet (isSelected) {
            backgroundColor = isSelected ? .blue100 : .gray100
            self.layer.borderColor = isSelected ? UIColor.blue400.cgColor : UIColor.gray200.cgColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    func setupView() {
        self.setTitleColor(.gray800, for: .normal)
        self.backgroundColor = .gray100
        self.layer.borderWidth = 1.adjusted
        self.layer.borderColor = UIColor.gray200.cgColor
        self.layer.cornerRadius = 8
        self.frame.size.height = 52.adjusted
    }
}
