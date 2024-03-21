//
//  HomeProveSuccessViewController.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 1/12/24.
//

import UIKit

import SnapKit
import Then

final class HomeProveSuccessViewController: BaseViewController {
    
    // MARK: - Properties
    
    
    // MARK: - UI Components
   
    private let popupView: HomeProveSuccessView
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
    }
    
    init(image: UIImage) {
        self.popupView = HomeProveSuccessView(image: image)
        super.init(nibName: nil, bundle:nil)
        modalTransitionStyle = .coverVertical
        modalPresentationStyle = .overFullScreen
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Functions
    
    override func setHierachy() {
        self.view.addSubviews(popupView)
    }
    
    override func setLayout() {
        popupView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setButtonEvent() {
        popupView.checkButton.addTarget(self, action: #selector(checkButtonDidTapped), for: .touchUpInside)
    }
    
    // MARK: - Custom Method
    
    @objc
    private func checkButtonDidTapped() {
        requestPutMissionImage(image: popupView.proveImageView.image ?? UIImage())
        
        dismiss(animated: true)
    }
}

// MARK: - Network Functions

extension HomeProveSuccessViewController {
    private func requestPutMissionImage(image: UIImage) {
        HomeAPI.shared.patchMissionImage { result in
            guard let result = self.validateResult(result) as? HomeMissionCheckResponse else { return }
            self.requestPutAtPreSignedURL(url: result.imgPresignedURL, image: image, fileName: result.fileName)
        }
    }

    private func requestPutAtPreSignedURL(url: String, image: UIImage, fileName: String) {
        HomeAPI.shared.putAtPreSignedURL(url: url, image: image) { result in
            guard let result = self.validateResult(result) as? BlankDataResponse else { self.requestPatchMissionImage(fileName: fileName); return }
            print("🐰", result)
            self.requestPatchMissionImage(fileName: fileName)
        }
    }
    
    private func requestPatchMissionImage(fileName: String) {
        HomeAPI.shared.patchMissionImage(fileName: fileName) { result in
            guard let result = self.validateResult(result) as? SimpleResponse else { return }
        }
    }
}
