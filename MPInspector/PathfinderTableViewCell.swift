import UIKit

class PathfinderTableViewCell: UITableViewCell {
    let subView = UIView()
    let typeLabel = UILabel()
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    let statusImageView = UIImageView()
    let seperatorImageView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        
        subView.addSubview(typeLabel)
        subView.addSubview(titleLabel)
        subView.addSubview(detailLabel)
        subView.addSubview(statusImageView)
        
        let subviewDict = [
            "typeLabel" : typeLabel,
            "titleLabel" : titleLabel,
            "detailLabel" : detailLabel,
            "statusImageView" : statusImageView,
            ] as [String : Any]
        
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(4)-[typeLabel]-(4)-|", options: [], metrics: nil, views: subviewDict))
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(4)-[titleLabel]-(4)-|", options: [], metrics: nil, views: subviewDict))
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(4)-[detailLabel]-(4)-|", options: [], metrics: nil, views: subviewDict))
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(4)-[statusImageView(12)]-(4)-|", options: [], metrics: nil, views: subviewDict))
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[typeLabel(40)]-[titleLabel]-[detailLabel(40)]-|", options: [], metrics: nil, views: subviewDict))
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[statusImageView(12)]-|", options: [], metrics: nil, views: subviewDict))
        
        subView.backgroundColor = UIColor.backgroundGrey
        subView.layer.cornerRadius = 8
        
        let bundle = Bundle(for: AllHeaderTableViewCell.self)
        let image = UIImage(named: "downArrow", in: bundle, compatibleWith: nil)!
        seperatorImageView.image = image
        seperatorImageView.contentMode = .scaleAspectFit
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        seperatorImageView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(subView)
        contentView.addSubview(seperatorImageView)
        
        let viewDict = [
            "subView" : subView,
            "seperatorImageView" : seperatorImageView,
            ] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[subView]-[seperatorImageView(20)]|", options: [], metrics: nil, views: viewDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|", options: [], metrics: nil, views: viewDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[seperatorImageView]-|", options: [], metrics: nil, views: viewDict))
    }
    
    override func prepareForReuse() {
        typeLabel.text = nil
        titleLabel.text = nil
        detailLabel.text = nil
        
        seperatorImageView.isHidden = false
        statusImageView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
