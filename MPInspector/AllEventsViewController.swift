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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        self.tableView.separatorStyle = .none
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
            cell.statusImg.backgroundColor = sections[indexPath.section].rows[indexPath.row - 1].networkRequestComplete ? UIColor.green : UIColor.gray
            if sections[indexPath.section].rows[indexPath.row - 1].networkRequestFailed {
                cell.statusImg.backgroundColor = UIColor.red
            }
            
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 22
        } else {
            if (sections[indexPath.section].rows[indexPath.row - 1].expanded) {
                return 104
            } else {
                return 22
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            sections[indexPath.section].expanded = !sections[indexPath.section].expanded;
            
            self.tableView.reloadData()
        } else if (sections[indexPath.section].rows[indexPath.row - 1].expandable) {
            self.tableView.reloadData()

            sections[indexPath.section].rows[indexPath.row - 1].expanded = !sections[indexPath.section].rows[indexPath.row - 1].expanded;
            
            self.tableView.reloadData()
        }
    }
}
