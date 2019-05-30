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
        feedData = AllSectionData(title: "Incorrect initialized", rows: []);
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        self.tableView.separatorStyle = .none
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
        cell.typeLabel.text = feedData.rows[indexPath.row].source

        cell.expandCell(expand: feedData.rows[indexPath.row].expanded)
        cell.statusImageView.isHidden = !feedData.rows[indexPath.row].isNetworkRequest
        cell.statusImageView.backgroundColor = feedData.rows[indexPath.row].networkRequestComplete ? UIColor.green : UIColor.gray
        if feedData.rows[indexPath.row].networkRequestFailed {
            cell.statusImageView.backgroundColor = UIColor.red
        }
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (feedData.rows[indexPath.row].expanded) {
            return 104
        } else {
            return 22
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.reloadData()

        feedData.rows[indexPath.row].expanded = !feedData.rows[indexPath.row].expanded;
        
        self.tableView.reloadData()
    }
}
