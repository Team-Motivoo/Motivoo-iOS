//
//  HomeProveView.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2024/01/11.
//

import UIKit

import SnapKit
import Then

final class HomeProveView: BaseView {
    
    // MARK: - Properties
    
    var galleryViewHandler: (() -> (Void))?
    var cameraViewHandler: (() -> (Void))?
    
    // MARK: - UI Components
    
    var missionLabel = UILabel()
    private var subtitleLabel = UILabel()
    var galleryView = HomeProveMissionView()
    private var cameraView = HomeProveMissionView()
    lazy var pictureStackView = UIStackView(arrangedSubviews: [cameraView,
                                                               galleryView])
    
    // MARK: - inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configurePictureTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Functions
    
    override func setUI() {
        missionLabel.do {
            $0.font = .heading3
            $0.textColor = .black
            $0.numberOfLines = 2
            $0.setLineSpacing(lineSpacing: 1.17.adjusted)
        }
        
        subtitleLabel.do {
            $0.font = .body6
            $0.textColor = .gray600
            $0.text = TextLiterals.Home.Prove.save
        }
        
        pictureStackView.do {
            $0.axis = .horizontal
            $0.spacing = 9.adjusted
            $0.alignment = .center
        }
        
        galleryView.configureView(image: ImageLiterals.icon.gallery,
                                  text: TextLiterals.Home.Prove.gallery)
        
        cameraView.configureView(image: ImageLiterals.icon.camera,
                                 text: TextLiterals.Home.Prove.takePicture)
        
    }
    
    override func setHierachy() {
        self.addSubviews(missionLabel,
                         subtitleLabel,
                         pictureStackView)
    }
    
    override func setLayout() {
        missionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30.adjusted)
            $0.top.equalToSuperview().inset(36.adjusted)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30.adjusted)
            $0.top.equalTo(missionLabel.snp.bottom).offset(6.adjusted)
        }
        
        pictureStackView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(45.adjusted)
            $0.leading.trailing.equalToSuperview().inset(30.adjusted)
        }
    }
    
    // MARK: - Custom Method
    
    private func configurePictureTapGesture() {
        let cameraViewTappedGesture = UITapGestureRecognizer(target: self, action: #selector(cameraViewDidTapped))
        let galleryMissionViewTappedGesture = UITapGestureRecognizer(target: self, action: #selector(galleryViewDidTapped))
        
        cameraView.addGestureRecognizer(cameraViewTappedGesture)
        galleryView.addGestureRecognizer(galleryMissionViewTappedGesture)
    }
    
    @objc
    private func cameraViewDidTapped() {
        cameraViewHandler?()
    }
    
    @objc
    private func galleryViewDidTapped() {
        galleryViewHandler?()
    }
}
