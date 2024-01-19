//
//  HomeCircularProgressView.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2024/01/09.
//

import UIKit

import SnapKit
import Then

final class HomeCircularProgressView: BaseView {
    
    // MARK: - Properties
    
    
    // MARK: - UI Components
    
    var myProgressLayer = CAShapeLayer()
    var parentProgressLayer = CAShapeLayer()
    private var trackLayer = CAShapeLayer()
    var mainImageView = UIImageView()
    var clearPercentLabel = UILabel()
//    private var childImageView = UIImageView()

    // MARK: - inits
    
    override init(frame: CGRect) {
        
        // 프레임 사이즈를 200x200으로 설정
        super.init(frame: CGRect(x: 0,
                                 y: 0,
                                 width: 308.adjusted,
                                 height: 308.adjusted)
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // 시작 각도 계산
        let startAngleRadians = 2 / CGFloat.pi  // 시작 각도 (라디안)
        let startAngleDegrees = startAngleRadians * 180 / CGFloat.pi  // 시작 각도 (도)
        let adjustedStartAngle = startAngleDegrees + 115.5  // 조정된 시작 각도
        let radius = (frame.size.width - 1.5) / 2
        let center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)

        // 원 경로상의 시작 위치 계산
        let startPercent = adjustedStartAngle * CGFloat.pi / 180
        let startPoint = UIBezierPath.point(atPercent: startPercent, withRadius: radius, andCenter: center)
//        childImageView.center = startPoint
    }

    // MARK: - Override Functions
    
    override func setUI() {
        
        self.do {
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = self.frame.size.width / 2
        }
        
        clearPercentLabel.do {
            $0.text = TextLiterals.Home.Main.clearPercent
            $0.font = .caption2
            $0.textColor = .gray600
        }
        
        let startAngleRadians = 2 / CGFloat.pi  // 시작 각도 (라디안)
        let startAngleDegrees = startAngleRadians * 180 / CGFloat.pi  // 시작 각도 (도)
        let adjustedStartAngle = startAngleDegrees + 110  // 조정된 시작 각도
        let endAngle = adjustedStartAngle + 245  // 끝 각도
        let radius = (frame.size.width - 1.5) / 2
        let center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let startPercent = adjustedStartAngle / 360
        let startPoint = UIBezierPath.point(atPercent: startPercent, withRadius: radius, andCenter: center)
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2,
                                                         y: frame.size.height / 2),
                                      radius: (frame.size.width - 1.5) / 2,
                                      startAngle: adjustedStartAngle * CGFloat.pi / 180,
                                      endAngle: endAngle * CGFloat.pi / 180,
                                      clockwise: true)
        
        let circleReversePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2,
                                                                y: frame.size.height / 2),
                                             radius: (frame.size.width - 1.5) / 2,
                                             startAngle: endAngle * CGFloat.pi / 180,
                                             endAngle: adjustedStartAngle * CGFloat.pi / 180,
                                             clockwise: false)
        
        trackLayer.do {
            $0.path = circlePath.cgPath
            $0.fillColor = UIColor.clear.cgColor
            $0.strokeColor = UIColor.gray100.cgColor
            $0.lineWidth = 9.0
            $0.strokeEnd = 1.0
        }

        myProgressLayer.do {
            $0.path = circlePath.cgPath
            $0.fillColor = UIColor.clear.cgColor
            $0.strokeColor = UIColor.blue400.cgColor
            $0.lineWidth = 9.0
            $0.strokeEnd = 0.0
        }
        
        parentProgressLayer.do {
            $0.path = circleReversePath.cgPath
            $0.fillColor = UIColor.clear.cgColor
            $0.strokeColor = UIColor.gray600.cgColor
            $0.lineWidth = 9.0
            $0.strokeEnd = 0.0
        }
        
        mainImageView.do {
            $0.image = ImageLiterals.img.missionMain
        }
    }
    
    override func setHierachy() {
        [trackLayer,
         myProgressLayer,
         parentProgressLayer].forEach {
            layer.addSublayer($0)
        }
        
        addSubviews(mainImageView, clearPercentLabel)
    }
    
    override func setLayout() {
        self.snp.makeConstraints {
            $0.height.width.equalTo(308.adjusted)
        }
        
        mainImageView.snp.makeConstraints {
            $0.width.equalTo(244.adjusted)
            $0.height.equalTo(184.adjusted)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-20.adjusted)
        }
        
        clearPercentLabel.snp.makeConstraints {
            $0.bottom.equalTo(mainImageView).offset(10.adjusted)
            $0.centerX.equalTo(mainImageView)
        }
    }

//    func updateImageViewPosition(to progress: CGFloat) {
//        let radius = (frame.size.width - 1.5) / 2
//        let centerPoint = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
//        let startAngleRadians = 2 / CGFloat.pi  // 시작 각도 (라디안)
//        let startAngleDegrees = startAngleRadians * 180 / CGFloat.pi  // 시작 각도 (도)
//        let adjustedStartAngle = startAngleDegrees + 110  // 조정된 시작 각도
//        let newPoint = UIBezierPath.point(atPercent: progress, withRadius: radius, andCenter: centerPoint)
////        childImageView.center = newPoint
//    }
    
    func setMyProgress(currentStep: Int, finalStep: Int, withAnimation: Bool) {
        var value: Double = Double()
        var adjustedValue = Double()

        if finalStep == 0 {
            value = 0
        } else {
            value = Double(currentStep) / Double(finalStep)
        }
        adjustedValue = (value > 1.0 ? 1.0 : (value < 0.0 ? 0.0 : value)) / 2.0
        let newValue = CGFloat(adjustedValue)
        if withAnimation {
            // 진행률에 따른 이미지 뷰 위치 업데이트 로직 추가
            let displayLink = CADisplayLink(target: self, selector: #selector(updateImageViewPositionDuringAnimation))
            displayLink.add(to: .main, forMode: .default)
            
            let trackAnimation = CABasicAnimation(keyPath: "strokeEnd")
            trackAnimation.duration = 2
            trackAnimation.fromValue = myProgressLayer.strokeEnd
            trackAnimation.toValue = newValue
            trackAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            myProgressLayer.strokeEnd = CGFloat(newValue)
            myProgressLayer.add(trackAnimation, forKey: "animateprogress")
        } else {
            myProgressLayer.strokeEnd = CGFloat(newValue)
//            updateImageViewPosition(to: CGFloat(newValue))
        }
    }

    // 애니메이션 도중 이미지 뷰 위치 업데이트
    @objc func updateImageViewPositionDuringAnimation() {
        let progress = myProgressLayer.presentation()?.strokeEnd ?? 0 - 200
//        updateImageViewPosition(to: progress)
    }
    
    func setParentProgress(currentStep: Int, finalStep: Int, withAnimation: Bool) {
        var value: Double = Double()
        var adjustedValue = Double()

        if finalStep == 0 {
            value = 0
        } else {
            value = Double(currentStep) / Double(finalStep)
        }
        adjustedValue = (value > 1.0 ? 1.0 : (value < 0.0 ? 0.0 : value)) * 0.5
        let newValue = CGFloat(adjustedValue)
        if withAnimation {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.do {
                $0.duration = 2
                $0.fromValue = parentProgressLayer.strokeEnd
                $0.toValue = newValue
                $0.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            }
            parentProgressLayer.strokeEnd = CGFloat(newValue)
            parentProgressLayer.add(animation, forKey: "animateReverseProgress")
        } else {
            parentProgressLayer.strokeEnd = CGFloat(newValue)
        }
    }
}
