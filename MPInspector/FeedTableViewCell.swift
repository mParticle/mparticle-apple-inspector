import UIKit

class FeedTableViewCell: UITableViewCell {
    let subView = UIView()
    let typeLabel = UILabel()
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    let statusImageView = UIImageView()
    let detailView = UITextView()

    private var collapsedConstraints: [NSLayoutConstraint] = []
    private var expandededConstraints: [NSLayoutConstraint] = []

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
        
        subView.backgroundColor = UIColor.backgroundGrey
        subView.layer.cornerRadius = 4
        
        typeLabel.setSizeFont(sizeFont: 6)
        typeLabel.textAlignment = .left
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 10)
        titleLabel.textAlignment = .left
        
        detailLabel.setSizeFont(sizeFont: 10)
        detailLabel.textAlignment = .right
        
        statusImageView.backgroundColor = UIColor.green
        statusImageView.layer.cornerRadius = 6
        statusImageView.clipsToBounds = true
        statusImageView.isHidden = true
        
        detailView.backgroundColor = UIColor.detailGrey
        detailView.font = UIFont(name: titleLabel.font.fontName, size: CGFloat(8.0))!
        detailView.isEditable = false
        detailView.layer.cornerRadius = 4
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(subView)
        contentView.addSubview(typeLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(statusImageView)
        contentView.addSubview(detailView)
        
        collapsedConstraints = [
            subView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12.0),
            subView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0),
            subView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1.0),
            subView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1.0),
            
            statusImageView.topAnchor.constraint(equalTo: subView.topAnchor, constant: 4.0),
            statusImageView.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -5.0),
            statusImageView.widthAnchor.constraint(equalToConstant: 12),
            statusImageView.heightAnchor.constraint(equalToConstant: 12),
            
            typeLabel.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 4.0),
            typeLabel.topAnchor.constraint(equalTo: subView.topAnchor, constant: 6.0),
            typeLabel.widthAnchor.constraint(equalToConstant: 54),
            
            titleLabel.leftAnchor.constraint(equalTo: typeLabel.rightAnchor, constant: 8.0),
            titleLabel.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -4.0),
            titleLabel.topAnchor.constraint(equalTo: subView.topAnchor, constant: 4.0),
            
            detailLabel.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -8.0),
            detailLabel.topAnchor.constraint(equalTo: subView.topAnchor, constant: 4.0),
            detailLabel.widthAnchor.constraint(equalToConstant: 20),
            
            detailView.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 4.0),
            detailView.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -4.0),
            detailView.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -4.0),
            detailView.heightAnchor.constraint(equalToConstant: 0),
        ]
        
        expandededConstraints = [
            subView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12.0),
            subView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0),
            subView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1.0),
            subView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1.0),
            
            statusImageView.topAnchor.constraint(equalTo: subView.topAnchor, constant: 4.0),
            statusImageView.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -5.0),
            statusImageView.widthAnchor.constraint(equalToConstant: 12),
            statusImageView.heightAnchor.constraint(equalToConstant: 12),
            
            typeLabel.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 4.0),
            typeLabel.topAnchor.constraint(equalTo: subView.topAnchor, constant: 6.0),
            typeLabel.widthAnchor.constraint(equalToConstant: 54),
            
            titleLabel.leftAnchor.constraint(equalTo: typeLabel.rightAnchor, constant: 8.0),
            titleLabel.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -4.0),
            titleLabel.topAnchor.constraint(equalTo: subView.topAnchor, constant: 4.0),
            
            detailLabel.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -8.0),
            detailLabel.topAnchor.constraint(equalTo: subView.topAnchor, constant: 4.0),
            detailLabel.widthAnchor.constraint(equalToConstant: 20),
            
            detailView.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 4.0),
            detailView.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -4.0),
            detailView.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -4.0),
            detailView.heightAnchor.constraint(equalToConstant: 80),
        ]
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
        NSLayoutConstraint.deactivate(self.collapsedConstraints + self.expandededConstraints)
        
        if expand {
            NSLayoutConstraint.activate(self.expandededConstraints)
        } else {
            NSLayoutConstraint.activate(self.collapsedConstraints)
        }
    }
}
