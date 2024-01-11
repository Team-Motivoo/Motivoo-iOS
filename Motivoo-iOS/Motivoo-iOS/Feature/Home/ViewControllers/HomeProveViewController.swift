//
//  HomeProveViewController.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2024/01/11.
//

import UIKit

import SnapKit
import Then

final class HomeProveViewController: BaseViewController {
    
    // MARK: - Properties
    
    var onDismissHandler: (() -> (Void))?
    var missionHandler: (() -> (Void))?
    var mission: String = String() {
        didSet {
            homeProveView.missionLabel.text = mission
        }
    }
    
    // MARK: - UI Components
    
    private var homeProveView = HomeProveView()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        missionHandler?()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        onDismissHandler?()
    }
    
    // MARK: - Override Functions
    
    override func setUI() {
        
    }
    
    override func setHierachy() {
        self.view.addSubview(homeProveView)
    }
    
    override func setLayout() {
        homeProveView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setButtonEvent() {
        homeProveView.cameraViewHandler = { [weak self] in
            guard let self else { return }
            print("cameraView Did Tapped!")
        }
        
        homeProveView.galleryViewHandler = { [weak self] in
            guard let self else { return }
            print("galleryView Did Tapped!")
        }
    }
}
