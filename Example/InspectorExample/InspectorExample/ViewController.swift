import UIKit
import mParticle_Apple_SDK
import mParticle_Apple_Inspector

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func debugClicked(_ sender: UIButton) {
        let inspectorVC =  InspectorViewController.init()
        
        // Starts the mParticle SDK
        let options = MParticleOptions(key: "6f654a8aa2a74b459312fe1a7b3fd26b", secret: "3yyLbIDqxuyxQdqnCKlq3aPlznHEfu4GXw9R_q0pgZa4a4-Y-lK6tB2gT7ZSIkQa")
        MParticle.sharedInstance().start(with: options)
        
        MParticle.sharedInstance().logLevel = .debug
        
        self.logCommerceEvent()
        
        let navigator = UINavigationController(rootViewController: inspectorVC)
        self.show(navigator, sender: self)
        
        self.logError()
    }
    
    func logCommerceEvent() {
        let product = MPProduct(name: "Awesome Movie", sku: "1234567890", quantity: 1, price: 9.99)
        product.brand = "A Studio"
        product.category = "Science Fiction"
        product.couponCode = "XYZ123"
        product.position = 1
        product["custom key"] = "custom value"; // A product may contain arbitrary custom key/value pairs
        
        let commerceEvent = MPCommerceEvent(action: .purchase, product: product)
        commerceEvent.checkoutOptions = "Credit Card";
        commerceEvent.screenName = "Timeless Movies";
        commerceEvent.checkoutStep = 4;
        commerceEvent["an_extra_key"] = "an_extra_value"; // A commerce event may contain arbitrary custom key/value pairs
        
        let transactionAttributes = MPTransactionAttributes()
        transactionAttributes.affiliation = "Movie seller";
        transactionAttributes.shipping = 1.23;
        transactionAttributes.tax = 0.87;
        transactionAttributes.revenue = 12.09;
        transactionAttributes.transactionId = "zyx098";
        commerceEvent.transactionAttributes = transactionAttributes;
        
        // Logs a commerce event
        MParticle.sharedInstance().logCommerceEvent(commerceEvent)
    }
    
    func logError() {
        let eventInfo = ["Cause": "Invalid stream URL"]
        
        MParticle.sharedInstance().logError("Test Error", eventInfo: eventInfo)
    }
}

