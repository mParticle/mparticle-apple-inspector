import UIKit

class FeedViewController: UITableViewController {
    private var feedData: AllSectionData
    
    required init(style: UITableView.Style, feedData: AllSectionData) {
        self.feedData = feedData
        super.init(style: style)
        
        self.title = "Recent Events"
        self.tableView.separatorStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        feedData = AllSectionData(title: "Inccorect initialized", rows: []);
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedData.rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedTableViewCell
        
        cell.titleLabel.text = feedData.rows[indexPath.row].title
        cell.detailView.text = feedData.rows[indexPath.row].body

        cell.expandCell(expand: feedData.rows[indexPath.row].expanded)
        cell.statusImageView.isHidden = !feedData.rows[indexPath.row].isNetworkRequest
        cell.statusImageView.backgroundColor = feedData.rows[indexPath.row].networkRequestComplete ? UIColor.gray : UIColor.green
        if feedData.rows[indexPath.row].networkRequestFailed {
            cell.statusImageView.backgroundColor = UIColor.red
        }
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        feedData.rows[indexPath.row].expanded = !feedData.rows[indexPath.row].expanded;
        
        self.tableView.reloadSections(IndexSet.init(integer: indexPath.section), with: .fade)
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
}
