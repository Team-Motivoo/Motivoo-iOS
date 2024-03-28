//
//  TipView+.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 3/28/24.
//

import UIKit

final class ToolTipView: UIView {
    private let containerView = UIView()
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.layer.cornerRadius = 33
        return label
    }()
    private let tipView = TipView()

    private let textColor: UIColor
    private let bgColor: UIColor

    init(title: String?, textColor: UIColor = .white, backgroundColor: UIColor = .gray, isTopTip: Bool = false) {
        label.text = title
        tipView.isTopTip = isTopTip
        self.textColor = textColor
        self.bgColor = backgroundColor

        super.init(frame: .zero)

        setupUI()
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupUI() {
        backgroundColor = .clear
        label.textColor = textColor
        containerView.backgroundColor = bgColor
        tipView.bgColor = bgColor
    }

    private func setupLayout() {
        addSubview(containerView)
        containerView.addSubview(label)
        containerView.addSubview(tipView)

        tipView.isTopTip ? layoutTopTip() : layoutBottomTip()
    }

    private func layoutTopTip() {
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview()
        }

        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5))
        }

        tipView.snp.makeConstraints{
            $0.size.equalTo(CGSize(width: 10, height: 5))
            $0.bottom.equalTo(containerView.snp.top)
            $0.centerX.equalToSuperview()
        }
    }

    private func layoutBottomTip() {
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }

        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5))
        }

        tipView.snp.makeConstraints{
            $0.size.equalTo(CGSize(width: 10, height: 5))
            $0.top.equalTo(containerView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
}

private class TipView: UIView {
    var isTopTip = false
    var bgColor = UIColor.gray

    override func draw(_ rect: CGRect) {
        backgroundColor = .clear
        bgColor.setFill()

        isTopTip ? drawTopTip(rect) : drawBottomTip(rect)
    }

    private func drawTopTip(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.midX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.close()
        path.fill()
    }

    private func drawBottomTip(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.close()
        path.fill()
    }
}
