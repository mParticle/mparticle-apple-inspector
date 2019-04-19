import UIKit

class FeedTableViewCell: UITableViewCell {
    let subView = UIView()
    let typeLabel = UILabel()
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    let statusImageView = UIImageView()
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
        
        typeLabel.setSizeFont(sizeFont: 10)
        typeLabel.textAlignment = .left
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 10)
        titleLabel.textAlignment = .left
        
        detailLabel.setSizeFont(sizeFont: 10)
        detailLabel.textAlignment = .right
        
        statusImageView.backgroundColor = UIColor.green
        statusImageView.layer.cornerRadius = 5
        statusImageView.clipsToBounds = true
        statusImageView.isHidden = true
        
        detailView.backgroundColor = UIColor.detailGrey
        detailView.font = UIFont(name: titleLabel.font.fontName, size: CGFloat(8.0))!
        detailView.isEditable = false
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        subView.addSubview(typeLabel)
        subView.addSubview(titleLabel)
        subView.addSubview(detailLabel)
        subView.addSubview(statusImageView)
        subView.addSubview(detailView)
        
        let subviewDict = [
            "typeLabel" : typeLabel,
            "titleLabel" : titleLabel,
            "detailLabel" : detailLabel,
            "statusImageView" : statusImageView,
            "detailView" : detailView,
            ] as [String : Any]
        
        detailCollapsed = NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[statusImageView(12)]-4-[detailView(0)]|", options: [], metrics: nil, views: subviewDict)
        detailExpanded = NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[statusImageView(12)]-4-[detailView(40)]-4-|", options: [], metrics: nil, views: subviewDict)
        
        subView.addConstraints(detailCollapsed)
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(4)-[typeLabel]", options: [], metrics: nil, views: subviewDict))
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(4)-[titleLabel]", options: [], metrics: nil, views: subviewDict))
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(4)-[detailLabel]", options: [], metrics: nil, views: subviewDict))
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[typeLabel(40)]-[titleLabel]-[detailLabel(20)]-|", options: [], metrics: nil, views: subviewDict))
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[typeLabel(40)]-[detailView]-2-|", options: [], metrics: nil, views: subviewDict))
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[statusImageView(12)]-4-|", options: [], metrics: nil, views: subviewDict))
        
        subView.backgroundColor = UIColor.backgroundGrey
        subView.layer.cornerRadius = 8
        
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
        typeLabel.text = nil
        titleLabel.text = nil
        detailLabel.text = nil
        
        statusImageView.isHidden = true
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
