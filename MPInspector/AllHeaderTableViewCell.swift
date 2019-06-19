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
        
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8.0),
            chevronImg.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronImg.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16.0),
            chevronImg.widthAnchor.constraint(equalToConstant: 12),
            chevronImg.heightAnchor.constraint(equalToConstant: 12),
            ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
