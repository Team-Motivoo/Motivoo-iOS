//
//  UIFont+.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2024/01/03.
//

import UIKit

extension UIFont{
    class var heading1: UIFont {
        return UIFont(name: AppFontName.medium.rawValue, size: 48)!
    }
    
    class var heading2: UIFont {
        return UIFont(name: AppFontName.semiBold.rawValue, size: 24)!
    }
    
    class var heading3: UIFont {
        return UIFont(name: AppFontName.medium.rawValue, size: 24)!
    }
    
    class var heading4: UIFont {
        return UIFont(name: AppFontName.semiBold.rawValue, size: 18)!
    }
    
    class var heading5: UIFont {
        return UIFont(name: AppFontName.semiBold.rawValue, size: 17)!
    }
    
    class var heading6: UIFont {
        return UIFont(name: AppFontName.semiBold.rawValue, size: 16)!
    }
    
    class var body1: UIFont {
        return UIFont(name: AppFontName.medium.rawValue, size: 18)!
    }
    
    class var body2: UIFont {
        return UIFont(name: AppFontName.regular.rawValue, size: 18)!
    }
    
    class var body3: UIFont {
        return UIFont(name: AppFontName.medium.rawValue, size: 17)!
    }
    
    class var body4: UIFont {
        return UIFont(name: AppFontName.regular.rawValue, size: 17)!
    }
    
    class var body5: UIFont {
        return UIFont(name: AppFontName.medium.rawValue, size: 16)!
    }
    
    class var body6: UIFont {
        return UIFont(name: AppFontName.regular.rawValue, size: 16)!
    }
    
    class var caption1: UIFont {
        return UIFont(name: AppFontName.semiBold.rawValue, size: 15)!
    }
    
    class var caption2: UIFont {
        return UIFont(name: AppFontName.regular.rawValue, size: 15)!
    }
}
