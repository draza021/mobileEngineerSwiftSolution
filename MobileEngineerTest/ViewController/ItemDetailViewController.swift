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
    
    
    private var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateDetailsView()
        
    }
}

// MARK: - Instance methods
extension ItemDetailViewController {
    
    func populateItem(_ item: Item) {
        self.item = item
    }
    
    private func updateDetailsView() {
        itemTitleLabel.text = item?.title
        itemDescriptionLabel.text = item?.description
        if let imageUrl = item?.image {
            itemImageView.kf.indicatorType = .activity
            itemImageView.kf.setImage(with: URL(string: imageUrl), placeholder: #imageLiteral(resourceName: "placeholder"))
        }
    }
}




