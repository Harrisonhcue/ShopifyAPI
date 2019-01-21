//
//  CollectionDetailsTableViewController.swift
//  ShopifyApplicationHarrison
//
//  Created by Harrison U-Ebili  on 2019-01-19.
//  Copyright © 2019 com.Harrisonhcue. All rights reserved.
//

import UIKit

class CollectionDetailsTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet var navBar:UINavigationBar!
    @IBOutlet var backBtn:UIBarButtonItem!
    @IBOutlet var collectionDetailsTable:UITableView!
    
    @IBOutlet var activityIndicator:UIActivityIndicatorView!
    @IBOutlet var modalView:UIView!
    
    var currentSetProducts:[Product]?
    var navTitle : String?
   var timer:Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.topItem?.title = navTitle!
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        modalView.isHidden = false
      collectionDetailsTable.isHidden = true
        modalView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
       //Force table reload every 10s
        self.timer = Timer(timeInterval: 2.0, target: self, selector: #selector(CollectionDetailsTableViewController.reloadTableView), userInfo: nil, repeats: false)
        RunLoop.main.add(self.timer!, forMode: RunLoop.Mode.default)
        
    }
    
   @objc func reloadTableView() {
   
    while(collectionDetailsTable.visibleCells.contains(where: {$0.imageView?.image == nil}))
    {
       
    }
    self.collectionDetailsTable.isHidden = false
    self.collectionDetailsTable.reloadData()
    activityIndicator.stopAnimating()
    modalView.isHidden = true
    
    }
    @IBAction func goBack(sender:UIBarButtonItem)
    {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentSetProducts!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell", for: indexPath) as? CollectionCell
        
        let product = currentSetProducts![indexPath.row]
        cell?.txtProdName.text = "\(product.name!)"
        cell?.txtProdInventory.text = "Qty:\(product.qty!)"
        cell?.txtCollectionTitle.text = "Collection ID: \(product.collectionID!)"
        cell?.imageView?.downloaded(from: product.imgUrl!)

        
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
    
}

