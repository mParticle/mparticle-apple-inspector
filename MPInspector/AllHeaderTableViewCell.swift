import Foundation
import UIKit

class AllHeaderTableViewCell: UITableViewCell {
    let chevronImg = UIImageView()
    let title = UILabel()
    
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

        title.setSizeFont(sizeFont: 12.0)

        let bundle = Bundle(for: AllHeaderTableViewCell.self)
        let image = UIImage(named: "expandChevron", in: bundle, compatibleWith: nil)!
        chevronImg.image = image
        
        chevronImg.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(chevronImg)
        contentView.addSubview(title)
        
        let viewsDict = [
            "image" : chevronImg,
            "username" : title,
            ] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image(12)]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[username]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[username]-[image(12)]-16-|", options: [], metrics: nil, views: viewsDict))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
