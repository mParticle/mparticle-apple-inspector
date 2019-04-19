import Foundation
import UIKit

let SelectedThemeKey = "SelectedTheme"

enum Theme: Int {
    case Default, Dark, Graphical
    
    var mainColor: UIColor {
        switch self {
        case .Default:
            return UIColor.orange
        case .Dark:
            return UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        case .Graphical:
            return UIColor(red: 10.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 1.0)
        }
    }
}

struct ThemeManager {
    static func currentTheme() -> Theme {
        if let storedTheme = (UserDefaults.standard.value(forKey: SelectedThemeKey) as AnyObject).integerValue {
            return Theme(rawValue: storedTheme)!
        } else {
            return .Default
        }
    }
    
    static func applyTheme(theme: Theme) {
        // 1
        UserDefaults.standard.setValue(theme.rawValue, forKey: SelectedThemeKey)
        UserDefaults.standard.synchronize()
        
        // 2
        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = theme.mainColor
    }
}

extension UIColor  {
    static var backgroundGrey = UIColor(red: 233/255.0, green: 233/255.0, blue: 233/255.0, alpha: 1.0)
    static var detailGrey = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
}
