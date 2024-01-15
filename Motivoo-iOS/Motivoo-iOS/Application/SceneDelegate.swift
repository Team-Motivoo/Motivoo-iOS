//
//  SceneDelegate.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2023/12/29.
//

import UIKit

import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = .light
        let navigationController = UINavigationController(rootViewController: SplashViewController())
        //        navigationController.isNavigationBarHidden = true
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
}
