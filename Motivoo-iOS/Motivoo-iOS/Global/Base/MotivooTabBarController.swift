//
//  MotivooTabBarController.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2024/01/05.
//

import UIKit

final class MotivooTabBarController: UITabBarController {
    
    private let homeViewController = HomeViewController()
    private let missionOverviewViewController = MissionOverviewViewController()
    private let myPageViewController = MyPageViewController()
    
    lazy var homeNavigationController = UINavigationController(rootViewController: homeViewController)
    lazy var missionOverviewNavigationController = UINavigationController(rootViewController: missionOverviewViewController)
    lazy var myPageNavigationController = UINavigationController(rootViewController: myPageViewController)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
        setNavigationController()
        setViewController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.frame.size.height = 100.adjusted
        tabBar.frame.origin.y = view.frame.height - 90.adjusted
    }
    
    private func setTabBar() {
        tabBar.backgroundColor = .white
        tabBar.itemPositioning = .centered
        tabBar.tintColor = .black
    }

    private func setNavigationController() {
        homeNavigationController.setNavigationBarHidden(true, animated: true)
        missionOverviewNavigationController.setNavigationBarHidden(true, animated: true)
        myPageNavigationController.setNavigationBarHidden(true, animated: true)
    }
    
    private func setViewController(){
        homeNavigationController.tabBarItem = setTabBarItem(image: ImageLiterals.icon.home,
                                                            selectedImage: ImageLiterals.icon.homeFill)
        
        missionOverviewNavigationController.tabBarItem = setTabBarItem(image: ImageLiterals.icon.mission,
                                                                       selectedImage: ImageLiterals.icon.missionFill)
        
        myPageNavigationController.tabBarItem = setTabBarItem(image: ImageLiterals.icon.my,
                                                              selectedImage: ImageLiterals.icon.myFill)
        
        viewControllers = [homeNavigationController,
                           missionOverviewNavigationController,
                           myPageNavigationController]

    }
    
    private func setTabBarItem(image: UIImage, selectedImage: UIImage) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: nil, image: image, selectedImage: selectedImage)
        return tabBarItem
    }
}
