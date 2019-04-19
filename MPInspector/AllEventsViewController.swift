import UIKit

class AllEventsViewController: UITableViewController {
    private var sections: [AllSectionData] = []
    
    required init(style: UITableView.Style, sections: [AllSectionData]) {
        self.sections = sections
        super.init(style: style)
        
        self.title = "All Events"
        self.tableView.separatorStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(AllRowTableViewCell.self, forCellReuseIdentifier: "row")
        self.tableView.register(AllHeaderTableViewCell.self, forCellReuseIdentifier: "header")
        
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sections[section].expanded {
            return sections[section].rows.count + 1
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath) as! AllHeaderTableViewCell
            
            let bundle = Bundle(for: AllHeaderTableViewCell.self)
            let expandImage = UIImage(named: "expandChevron", in: bundle, compatibleWith: nil)!
            let collapseImage = UIImage(named: "collapseChevron", in: bundle, compatibleWith: nil)!
            
            if (sections[indexPath.section].expanded) {
                cell.chevronImg.image = collapseImage
            } else {
                cell.chevronImg.image = expandImage
            }
            cell.title.text = sections[indexPath.section].title
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "row", for: indexPath) as! AllRowTableViewCell
            
            cell.title.text = sections[indexPath.section].rows[indexPath.row - 1].title
            cell.detailView.text = sections[indexPath.section].rows[indexPath.row - 1].body
            cell.expandCell(expand: sections[indexPath.section].rows[indexPath.row - 1].expanded)
            cell.statusImg.isHidden = !sections[indexPath.section].rows[indexPath.row - 1].isNetworkRequest
            cell.statusImg.backgroundColor = sections[indexPath.section].rows[indexPath.row - 1].networkRequestComplete ? UIColor.gray : UIColor.green
            if sections[indexPath.section].rows[indexPath.row - 1].networkRequestFailed {
                cell.statusImg.backgroundColor = UIColor.red
            }
            
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            sections[indexPath.section].expanded = !sections[indexPath.section].expanded;
            
            self.tableView.reloadSections(IndexSet.init(integer: indexPath.section), with: .fade)
        } else if (sections[indexPath.section].rows[indexPath.row - 1].expandable) {
            sections[indexPath.section].rows[indexPath.row - 1].expanded = !sections[indexPath.section].rows[indexPath.row - 1].expanded;
            
            self.tableView.reloadSections(IndexSet.init(integer: indexPath.section), with: .fade)
        } else {
            let error = NSError.init()
            let pathfinderVC = PathfinderViewController(error: error)
            self.navigationController?.pushViewController(pathfinderVC, animated: true)
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    enum Section: NSInteger {
        case sdkState = 0
        case apiUsage = 1
        case kitState = 2
        case networkUsage = 3
        case databaseState = 4
    }
}
