import Foundation
import UIKit

let SelectedThemeKey = "SelectedTheme"

enum Theme: Int {
    case Default, Dark, Graphical
    
    var mainColor: UIColor {
        switch self {
        case .Default:
            return UIColor(red: 107.0/255.0, green: 250.0/255.0, blue: 207.0/255.0, alpha: 1.0)
        case .Dark:
            return UIColor(red: 8.0/255.0, green: 85.0/255.0, blue: 92.0/255.0, alpha: 1.0)
        case .Graphical:
            return UIColor(red: 10.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 1.0)
        }
    }
    
    var secondaryColor: UIColor {
        switch self {
        case .Default:
            return UIColor(red: 8.0/255.0, green: 85.0/255.0, blue: 92.0/255.0, alpha: 1.0)
        case .Dark:
            return UIColor(red: 31.0/255.0, green: 31.0/255.0, blue: 31.0/255.0, alpha: 1.0)
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
}

extension UIColor  {
    static var backgroundGrey = UIColor(red: 207/255.0, green: 207/255.0, blue: 207/255.0, alpha: 1.0)
    static var detailGrey = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
}
