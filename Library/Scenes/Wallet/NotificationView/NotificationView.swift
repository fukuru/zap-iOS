//
//  Library
//
//  Created by 0 on 28.10.19.
//  Copyright © 2019 Zap. All rights reserved.
//

import Foundation

final class NotificationView: UIView {
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var headlineLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    
    var notificationViewModel: NotificationViewModel? {
        didSet {
            updateNotification()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundView.layer.cornerRadius = 20
        backgroundView.backgroundColor = UIColor.Zap.seaBlue
        
        Style.Label.headline.apply(to: headlineLabel)
        Style.Label.body.apply(to: bodyLabel)
    }
    
    private func setup() {
        let views = Bundle.library.loadNibNamed("NotificationView", owner: self, options: nil)
        guard let content = views?.first as? UIView else { return }

        addAutolayoutSubview(content)

        content.backgroundColor = UIColor.Zap.background
        
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            content.bottomAnchor.constraint(equalTo: bottomAnchor),
            content.leadingAnchor.constraint(equalTo: leadingAnchor),
            content.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func updateNotification() {
        headlineLabel.text = notificationViewModel?.title
        bodyLabel.text = notificationViewModel?.message
    }
    
    @IBAction private func notificationTapped(_ sender: Any) {
        notificationViewModel?.action()
    }
}