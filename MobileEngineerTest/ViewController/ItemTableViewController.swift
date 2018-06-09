//
//  ItemTableViewController.swift
//  MobileEngineerTest
//
//  Created by Drago on 6/6/18.
//  Copyright © 2018 nsiddevelopment. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {

    private var items = [Item]()
    private var activityIndicatorView: UIActivityIndicatorView!
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
        showActivityIndicator()
        setupTableView()
        
    }
    
}

// MARK: - Private instance methods
private extension ItemTableViewController {
    
    func populateTableView(with data: [Item]) {
        DispatchQueue.main.async { [weak self] in
            self?.items = data
            self?.tableView.reloadData()
            
        }
    }
    
    func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 54
    }
    
    func fetchData() {
        let itemClient = ItemAPIClient()
        let allItemsEndpoint = ItemEndpoint.allItems
        
        itemClient.fetchItems(with: allItemsEndpoint) { [weak self] result in
            switch result {
            case .error(let error):
                self?.showAlert(error)
            case .success(let value):
                self?.populateTableView(with: value)
                self?.hideActivityIndicator()
            }
        }
    }
    
    func showAlert(_ error: APIError) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: error.title,
                                                    message: error.message,
                                                    preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(alertAction)
            
            self.present(alertController, animated: true)
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicatorView.stopAnimating()
            self?.activityIndicatorView.hidesWhenStopped = true
            self?.tableView.separatorStyle = .singleLine
        }
    }
    
    func showActivityIndicator() {
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        tableView.backgroundView = activityIndicatorView
        tableView.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        tableView.separatorStyle = .none
        activityIndicatorView.startAnimating()
    }
}

// MARK: - Table view data source
extension ItemTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.reuseIdentifier, for: indexPath) as! ItemCell
        let cellTitle = items[indexPath.row].title
        let cellDescription = items[indexPath.row].description
        cell.populate(with: cellTitle, description: cellDescription)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ItemDetailViewController") as! ItemDetailViewController
        vc.populateItem(items[indexPath.row])
        show(vc, sender: self)
    }
    
}







