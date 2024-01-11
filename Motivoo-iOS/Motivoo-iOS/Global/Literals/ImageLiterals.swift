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
        static var kakaoLogin: UIImage { .load(named: "kakaoLogin")}
        static var appleLogin: UIImage { .load(named: "appleLogin")}
        static var missionTree: UIImage { .load(named: "mission_tree")}
        static var missionDrink: UIImage { .load(named: "mission_drink")}
        static var child: UIImage { .load(named: "child")}
        static var parent: UIImage { .load(named: "parent")}
        static var missionMain: UIImage { .load(named: "mission_main")}

    }
    
    enum icon {
        
        // MARK: - TabBar
        
        static var home: UIImage { .load(named: "home")}
        static var homeFill: UIImage { .load(named: "home_fill")}
        static var mission: UIImage { .load(named: "mission")}
        static var missionFill: UIImage { .load(named: "mission_fill")}
        static var my: UIImage { .load(named: "my")}
        static var myFill: UIImage { .load(named: "my_fill")}
        static var shoes: UIImage { .load(named: "shoes")}
        static var notice: UIImage { .load(named: "notice")}


        
        // MARK: - MyPage
        
        static var rightArrow: UIImage { .load(named: "right_arrow")}
        
    }
}

