import UIKit

class AllRowTableViewCell: UITableViewCell {
    let subView = UIView()
    let statusImg = UIImageView()
    let title = UILabel()
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
        
        title.setSizeFont(sizeFont: 10.0)

        statusImg.layer.cornerRadius = 6
        statusImg.clipsToBounds = true
        statusImg.isHidden = true
        
        detailView.backgroundColor = UIColor.detailGrey
        detailView.font = UIFont(name: title.font.fontName, size: CGFloat(8.0))!
        detailView.isEditable = false
        detailView.layer.cornerRadius = 4

        subView.translatesAutoresizingMaskIntoConstraints = false
        statusImg.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(subView)
        contentView.addSubview(statusImg)
        contentView.addSubview(title)
        contentView.addSubview(detailView)

        collapsedConstraints = [
            subView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12.0),
            subView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0),
            subView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1.0),
            subView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1.0),
            
            statusImg.topAnchor.constraint(equalTo: subView.topAnchor, constant: 4.0),
            statusImg.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -5.5),
            statusImg.widthAnchor.constraint(equalToConstant: 12),
            statusImg.heightAnchor.constraint(equalToConstant: 12),
            
            title.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 4.0),
            title.rightAnchor.constraint(equalTo: statusImg.leftAnchor, constant: -8.0),
            title.topAnchor.constraint(equalTo: subView.topAnchor, constant: 4.0),
            
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
            
            statusImg.topAnchor.constraint(equalTo: subView.topAnchor, constant: 1.0),
            statusImg.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -5.5),
            statusImg.widthAnchor.constraint(equalToConstant: 12),
            statusImg.heightAnchor.constraint(equalToConstant: 12),
            
            title.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 4.0),
            title.rightAnchor.constraint(equalTo: statusImg.leftAnchor, constant: -8.0),
            title.topAnchor.constraint(equalTo: subView.topAnchor, constant: 4.0),
            
            detailView.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 4.0),
            detailView.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -4.0),
            detailView.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -4.0),
            detailView.heightAnchor.constraint(equalToConstant: 76),
        ]
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
        NSLayoutConstraint.deactivate(self.collapsedConstraints + self.expandededConstraints)
        
        if expand {
            NSLayoutConstraint.activate(self.expandededConstraints)
        } else {
            NSLayoutConstraint.activate(self.collapsedConstraints)
        }
    }
}

extension UILabel {
    func setSizeFont (sizeFont: Double) {
        self.font =  UIFont(name: self.font.fontName, size: CGFloat(sizeFont))!
        self.sizeToFit()
    }
}
