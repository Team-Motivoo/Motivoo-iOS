//
//  HomeProveViewController.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2024/01/11.
//

import AVFoundation
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
    private var imagePickerViewController = UIImagePickerController()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        missionHandler?()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        onDismissHandler?()
    }
    
    // MARK: - Override Functions
    
    override func setUI() {
        imagePickerViewController.do {
            $0.delegate = self
        }
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
            presentCamera()
        }
        
        homeProveView.galleryViewHandler = { [weak self] in
            guard let self else { return }
            presentGallery()
        }
    }
    
    // MARK: - Custom Function
    
    private func presentGallery() {
        imagePickerViewController.sourceType = .photoLibrary
        imagePickerViewController.allowsEditing = true
        self.present(self.imagePickerViewController, animated: true)
    }
    
    private func presentCamera() {
    #if targetEnvironment(simulator)
        fatalError()
    #endif
        
        imagePickerViewController.sourceType = .camera
        imagePickerViewController.allowsEditing = true
        imagePickerViewController.mediaTypes = ["public.image"]
        
        AVCaptureDevice.requestAccess(for: .video) { [weak self] isAuthorized in
            guard isAuthorized else {
                self?.showAlertGoToSetting(title: TextLiterals.Home.Auth.cameraNoAuthTitle,
                                          message: TextLiterals.Home.Auth.cameraNoAuthMessage)
                return
            }
            
            DispatchQueue.main.async {
                self?.present(self?.imagePickerViewController ?? UIImagePickerController(), animated: true)
            }
        }
    }
    
    func bindQuest(content: String) {
        homeProveView.missionLabel.text = content
    }
}

// MARK: - UIImagePickerControllerDelegate

extension HomeProveViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage? = nil // update 할 이미지
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage // 수정된 이미지가 있을 경우
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage // 원본 이미지가 있을 경우
        }
        
        picker.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
        
        let popupViewController = HomeProveSuccessViewController(image: newImage ?? UIImage())
        popupViewController.modalPresentationStyle = .overFullScreen
        self.present(popupViewController, animated: true)
    }
}
