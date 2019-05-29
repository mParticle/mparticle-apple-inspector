import UIKit
import mParticle_Apple_SDK
import mParticle_Apple_Inspector

class MainTableViewController: UITableViewController {
    var inspectorVC =  InspectorViewController.init()

    var cellTitles = ["Log Simple Event", "Log Event", "Log Screen", "Log Commerce Event", "Log Timed Event",
    "Log Error", "Set User Attribute", "Increment User Attribute",
    "Set Session Attribute", "Increment Session Attribute"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "mParticleCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellTitles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mParticleCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.minimumScaleFactor = 0.5
        cell.textLabel?.text = self.cellTitles[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.logSimpleEvent()
        case 1:
            self.logEvent()
        case 2:
            self.logScreen()
        case 3:
            self.logCommerceEvent()
        case 4:
            self.logTimedEvent()
        case 5:
            self.logError()
        case 6:
            self.setUserAttribute()
        case 7:
            self.incrementUserAttribute()
        case 8:
            self.setSessionAttribute()
        case 9:
            self.incrementSessionAttribute()
        default:
            NSLog("Invalid row selected: %@", indexPath.row)
        }
    }

    @IBAction func debugClicked(_ sender: Any) {
        self.navigationController?.pushViewController(inspectorVC, animated: true)
    }
    
    func logSimpleEvent() {
        NSLog("Performing Log Simple Event")

        MParticle.sharedInstance().logEvent("Simple Event",
                                            eventType: MPEventType.other,
                                            eventInfo: ["SimpleKey": "Simplevalue"])
    }
    
    func logEvent() {
        NSLog("Performing Log Event")

        let event = MPEvent.init(name: "Event Name", type: MPEventType.transaction)
        event!.info = ["A_String_Key": "A String Value", "A Number Key": 42, "A Date Key": NSDate.init()]
        event!.addCustomFlag("Top Secret", withKey: "Not_forwarded_to_providers")
        
        MParticle.sharedInstance().logEvent(event!)
    }
    
    func logScreen() {
        NSLog("Performing Log Screen Event")

        MParticle.sharedInstance().logScreen("Home Screen", eventInfo: nil)
    }
    
    func logCommerceEvent() {
        NSLog("Performing Log Commerce Event")

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
    
    func logTimedEvent() {
        NSLog("Performing Log Timed Event")

        let eventName = "Timed Event"
        let timedEvent = MPEvent.init(name: eventName, type: MPEventType.transaction)
        MParticle.sharedInstance().beginTimedEvent(timedEvent!)
        
        let delay = Int.random(in: 1 ..< 5)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            let retrievedTimedEvent = MParticle.sharedInstance().event(withName: eventName)
            
            if (retrievedTimedEvent != nil) {
                MParticle.sharedInstance().endTimedEvent(retrievedTimedEvent!)
            }
        }
    }
    
    func logError() {
        NSLog("Performing Log Error")

        let eventInfo = ["Cause": "Invalid stream URL"]
        
        MParticle.sharedInstance().logError("Test Error", eventInfo: eventInfo)
    }
    
    func setUserAttribute() {
        NSLog("Performing Set User Attribute")

        let age = String(Int.random(in: 21 ..< 80))
        MParticle.sharedInstance().identity.currentUser?.setUserAttribute(mParticleUserAttributeAge, value: age)
        
        let gender = ["m", "f", "a", "i"]
        let selection = Int.random(in: 0 ..< 3)
        MParticle.sharedInstance().identity.currentUser?.setUserAttribute(mParticleUserAttributeGender, value: gender[selection])

        MParticle.sharedInstance().identity.currentUser?.setUserAttribute("Achieved Level", value: 4)
    }

    func incrementUserAttribute() {
        NSLog("Performing Increment User Attribute")

        MParticle.sharedInstance().identity.currentUser?.incrementUserAttribute("Achieved Level", byValue: 1)
    }
    
    func setSessionAttribute() {
        NSLog("Performing Set Session Attribute")

        MParticle.sharedInstance().setSessionAttribute("Station", value: "Classic Rock")
        MParticle.sharedInstance().setSessionAttribute("Song Count", value: 1)
    }
    
    func incrementSessionAttribute() {
        NSLog("Performing Increment Session Attribute")

        MParticle.sharedInstance().incrementSessionAttribute("Song Count", byValue: 1)
    }
}
