import UIKit
import mParticle_Apple_SDK

public class InspectorViewController: UITabBarController, UIPopoverControllerDelegate {
    private var shownViewController: UIViewController?
    private var dataSourceProvider: InspectorDataSourceProvider

    public required init() {
        self.dataSourceProvider = InspectorDataSourceProvider()

        super.init(nibName: nil, bundle: nil)
        
        MPListenerController.sharedInstance().addSdkListener(self.dataSourceProvider)
        
        let theme = ThemeManager.currentTheme()
        ThemeManager.applyTheme(theme: theme)
        
        self.viewControllers = [AllEventsViewController(style: .plain, sections: [dataSourceProvider.apiUsage, dataSourceProvider.databaseState, dataSourceProvider.networkUsage]), FeedViewController(style: .plain, feedData: dataSourceProvider.allData)]
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.dataSourceProvider = InspectorDataSourceProvider()

        super.init(coder: aDecoder)
        
        MPListenerController.sharedInstance().addSdkListener(self.dataSourceProvider)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    @objc func settings() {
        let settingsViewController = storyboard?.instantiateViewController(withIdentifier: "SettingsTableViewController")
        
        settingsViewController?.modalPresentationStyle = .popover
        settingsViewController?.modalTransitionStyle = .coverVertical
        settingsViewController?.popoverPresentationController?.delegate = self as? UIPopoverPresentationControllerDelegate
        present(settingsViewController!, animated: true, completion: nil)
    }
}

extension InspectorViewController: UITabBarControllerDelegate  {
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false // Make sure you want this as false
        }
        
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        
        return true
    }
}
