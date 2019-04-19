import UIKit

class AllRowTableViewCell: UITableViewCell {
    let subView = UIView()
    let statusImg = UIImageView()
    let title = UILabel()
    let detailView = UITextView()
    
    private var detailCollapsed: [NSLayoutConstraint] = []
    private var detailExpanded: [NSLayoutConstraint] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        title.setSizeFont(sizeFont: 10.0)

        statusImg.layer.cornerRadius = 6
        statusImg.clipsToBounds = true
        statusImg.isHidden = true
        
        detailView.backgroundColor = UIColor.orange.withAlphaComponent(0.0)
        detailView.font = UIFont(name: title.font.fontName, size: CGFloat(8.0))!
        detailView.isEditable = false
        
        statusImg.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        subView.addSubview(statusImg)
        subView.addSubview(title)
        subView.addSubview(detailView)
        
        let viewsDict = [
            "image" : statusImg,
            "title" : title,
            "detailView" : detailView
            ] as [String : Any]
        
        detailCollapsed = NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[image(12)]-4-[detailView(0)]|", options: [], metrics: nil, views: viewsDict)
        detailExpanded = NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[image(12)]-4-[detailView(80)]-4-|", options: [], metrics: nil, views: viewsDict)
        
        subView.addConstraints(detailCollapsed)
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[title]", options: [], metrics: nil, views: viewsDict))
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[title]-[image(12)]-5.5-|", options: [], metrics: nil, views: viewsDict))
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[detailView]|", options: [], metrics: nil, views: viewsDict))
        
        subView.backgroundColor = UIColor.backgroundGrey
        subView.layer.cornerRadius = 4
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(subView)
        
        let viewDict = [
            "subView" : subView,
            ] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-1-[subView]-1-|", options: [], metrics: nil, views: viewDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[subView]-10-|", options: [], metrics: nil, views: viewDict))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        title.text = nil
        
        self.expandCell(expand: false)
    }
    
    func expandCell(expand: Bool) {
        if expand {
            subView.removeConstraints(detailCollapsed)
            
            subView.addConstraints(detailExpanded)
        } else {
            subView.removeConstraints(detailExpanded)
            
            subView.addConstraints(detailCollapsed)
        }
    }
}

extension UILabel {
    func setSizeFont (sizeFont: Double) {
        self.font =  UIFont(name: self.font.fontName, size: CGFloat(sizeFont))!
        self.sizeToFit()
    }
}
