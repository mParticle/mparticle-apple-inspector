import UIKit

class AllRowData: NSObject {
    public var title: String?
    public var body: String?
    public var source: String?
    public var isNetworkRequest = false
    public var networkRequestComplete = false
    public var networkRequestFailed = false
    public var expandable = true
    public var expanded = false
    
    public var previousData: AllRowData?
    
    required init(title: String, body: String, source: String) {
        super.init()
        
        self.title = title
        self.body = body
        self.source = source
    }
    
    required override init() {
        super.init()
    }
}
