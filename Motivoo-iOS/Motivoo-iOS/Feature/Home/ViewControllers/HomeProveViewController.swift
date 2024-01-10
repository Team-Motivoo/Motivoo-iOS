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
        
    // MARK: - UI Components
    
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        onDismissHandler?()
    }
    
    // MARK: - Override Functions
    
    override func setUI() {
        
    }
    
    override func setHierachy() {
        
    }
    
    override func setLayout() {
        
    }
    
    override func setButtonEvent() {
        
    }
    
}
