//  Created by iOS Development Company on 13/01/16.
//  Copyright © 2021 The App Developers. All rights reserved.
//

import UIKit

enum ToolytFont: String {
    
    case openSansRegular = "OpenSans-Regular"
    case openSansMedium = "OpenSans-Medium"
    case openSansSemibold = "OpenSans-Semibold"
    case openSansBold = "OpenSans-Bold"
    
}

extension UIFont {
    
    class func ToolytFontWith(_ name: ToolytFont, size: CGFloat) -> UIFont{
        return UIFont(name: name.rawValue, size: size)!
    }
}
