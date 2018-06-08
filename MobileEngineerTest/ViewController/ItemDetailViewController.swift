//
//  ItemDetailViewController.swift
//  MobileEngineerTest
//
//  Created by Drago on 6/6/18.
//  Copyright © 2018 nsiddevelopment. All rights reserved.
//

import UIKit
import Kingfisher

class ItemDetailViewController: UIViewController {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    
    
    var itemTitle: String?
    var itemDescription: String?
    var imageUrl: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        updateDetailsView()
        
    }
}

// MARK: - Instance methods
extension ItemDetailViewController {
    
    func populateDetails(_ item: Item) {
        itemTitle = item.title
        itemDescription = item.description
        imageUrl = item.image
    }
    
    private func updateDetailsView() {
        itemTitleLabel.text = itemTitle
        itemDescriptionLabel.text = itemDescription
        if let imageUrl = imageUrl {
            itemImageView.kf.indicatorType = .activity
            itemImageView.kf.setImage(with: URL(string: imageUrl), placeholder: #imageLiteral(resourceName: "placeholder"))
        }
    }
}




