import UIKit

class AllSectionData: NSObject {
    public var title: String?
    public var expanded = false
    public var rows: [AllRowData] = []

    required init(title: String, rows: [AllRowData]) {
        super.init()
        
        self.title = title
        self.rows = rows
    }
    
    required override init() {
        super.init()
    }
}
