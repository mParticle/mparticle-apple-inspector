import UIKit

class PathfinderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var headerView:UIView!
    var bodyView:UIView!
    var tableView:UITableView!
    
    var tableInfo = [["API", "mParticle.logEvent()", "+42s"], ["msg", "messages", "1"], ["msg", "uploads", "1"], ["network", "Events", ""]]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 180, height: 25))
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 180, height: 25))
        imageView.contentMode = .scaleAspectFit
        let bundle = Bundle(for: AllHeaderTableViewCell.self)
        let image = UIImage(named: "mP-Logo", in: bundle, compatibleWith: nil)!
        imageView.image = image
        logoContainer.addSubview(imageView)
        navigationItem.titleView = logoContainer
        // Do any additional setup after loading the view.
        
        headerView = UIView()
        headerView.backgroundColor = .white
        self.view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        bodyView = UIView()
        bodyView.backgroundColor = .white
        self.view.addSubview(bodyView)
        
        bodyView.translatesAutoresizingMaskIntoConstraints = false
       
        let viewsDict = [
            "header" : headerView,
            "body" : bodyView,
            ] as [String : NSObject]
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-64-[header(64)][body]|", options: [], metrics: nil, views: viewsDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[header]|", options: [], metrics: nil, views: viewsDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[body]|", options: [],metrics: nil, views: viewsDict))

        self.layoutHeader()
        self.layoutBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required init(error aError: Error) {
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    func layoutHeader() {
        let headerLabel = UILabel()
        headerLabel.text = "Pathfinder: API: mParticle.logEvent()"
        headerLabel.font = UIFont.systemFont(ofSize: 16.0)
        headerLabel.textAlignment = .center
        headerView.addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let viewsDict = [
            "header" : headerView,
            "headerLabel" : headerLabel,
            ] as [String : NSObject]
        
        headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[headerLabel(30)]|", options: [], metrics: nil, views: viewsDict))
        headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[headerLabel]-|", options: [], metrics: nil, views: viewsDict))
    }
    
    func layoutBody() {
        tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(PathfinderTableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.backgroundColor = UIColor.clear
        
        bodyView.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let viewsDict = [
            "body" : headerView,
            "tableView" : tableView,
            ] as [String : NSObject]
        
        bodyView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: [], metrics: nil, views: viewsDict))
        bodyView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tableView]-|", options: [], metrics: nil, views: viewsDict))
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableInfo.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tableHeaderView = UIView()
        tableHeaderView.backgroundColor = UIColor.detailGrey
        tableHeaderView.layer.cornerRadius = 8
        
        let label = UILabel()
        label.text = "mParticle.logEvent() to Network"
        label.font = UIFont.boldSystemFont(ofSize: 14)

        tableHeaderView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let viewsDict = [
            "label" : label,
            ] as [String : Any]
        
        tableHeaderView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[label]-|", options: [], metrics: nil, views: viewsDict))
        tableHeaderView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]|", options: [], metrics: nil, views: viewsDict))
        
        return tableHeaderView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PathfinderTableViewCell
        cell.backgroundColor = nil
        
        cell.typeLabel.text = tableInfo[indexPath.row][0]
        cell.titleLabel.text = tableInfo[indexPath.row][1]
        if tableInfo[indexPath.row][2] == "" {
            cell.statusImageView.isHidden = false
        } else {
            cell.detailLabel.text = tableInfo[indexPath.row][2]
        }
        
        if (indexPath.row == tableInfo.count-1) {
            cell.seperatorImageView.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

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
