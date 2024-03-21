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
        requestPatchMissionImage(image: popupView.proveImageView.image ?? UIImage())
        dismiss(animated: true)
    }
}

// MARK: - Network Functions

extension HomeProveSuccessViewController {
    private func requestPatchMissionImage(image: UIImage) {
        let param = HomeMissionImageRequest(imgPrefix: "mission/")
        HomeAPI.shared.patchMissionImage(param: param) { result in
            guard let result = self.validateResult(result) as? HomeMissionCheckResponse else { return }
            self.requestPutAtPreSignedURL(url: result.imgPresignedURL, image: image)
        }
    }

    private func requestPutAtPreSignedURL(url: String, image: UIImage) {
        HomeAPI.shared.putAtPreSignedURL(url: url, image: image) { result in
            guard let result = self.validateResult(result) as? SimpleResponse else { return }
            print("🐰", result)
        }
    }
}
