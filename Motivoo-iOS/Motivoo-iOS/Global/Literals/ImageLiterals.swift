//
//  Image.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2023/12/29.
//

import UIKit


enum ImageLiterals {
    
    enum img {
        
        // MARK: - OnBoarding
        
        static var motivooLogo: UIImage { .load(named: "motivooLogo")}
        static var motivooTextLogo: UIImage { .load(named: "img_logo")}
        static var loginAfter: UIImage { .load(named: "img_login_after")}
        static var login: UIImage { .load(named: "img_login")}
        static var kakaoLogin: UIImage { .load(named: "solid_btn_kakao")}
        static var appleLogin: UIImage { .load(named: "solid_btn_apple")}
        static var missionTree: UIImage { .load(named: "mission_tree")}
        static var missionDrink: UIImage { .load(named: "mission_drink")}
        static var child: UIImage { .load(named: "child")}
        static var parent: UIImage { .load(named: "parent")}
        static var missionMain: UIImage { .load(named: "mission_main")}
        static var fitnessCircle: UIImage { .load(named: "img_onboarding_fitness")}
        static var cameraCircle: UIImage { .load(named: "img_onboarding_camera")}
        static var galleryCircle: UIImage { .load(named: "img_onboarding_gallery")}
        static var missionCompleted: UIImage { .load(named: "img_home_mission_complete")}

    }
    
    enum icon {

        // MARK: - OnBaording

        static var info: UIImage { .load(named: "icon_info")}
        static var checkbox_active: UIImage { .load(named: "checkbox_active")}
        static var checkbox_default: UIImage { .load(named: "checkbox_default")}
        static var code: UIImage { .load(named: "img_code")}

        // MARK: - TabBar
        
        static var home: UIImage { .load(named: "home")}
        static var homeFill: UIImage { .load(named: "home_fill")}
        static var mission: UIImage { .load(named: "mission")}
        static var missionFill: UIImage { .load(named: "mission_fill")}
        static var my: UIImage { .load(named: "my")}
        static var myFill: UIImage { .load(named: "my_fill")}
        
        // MARK: - Home
        
        static var camera: UIImage { .load(named: "icon_camera")}
        static var gallery: UIImage { .load(named: "icon_gallery")}
        static var shoes: UIImage { .load(named: "shoes")}
        static var notice: UIImage { .load(named: "notice")}
        static var checkActive: UIImage { .load(named: "check_active")}

        
        // MARK: - MyPage
        
        static var rightArrow: UIImage { .load(named: "new_right_arrow")}
        static var thumb: UIImage { .load(named: "thumb")}
        
        // MARK: - MissonOverView
        static var noexercise: UIImage { .load(named: "noexercise")}


    }
}

