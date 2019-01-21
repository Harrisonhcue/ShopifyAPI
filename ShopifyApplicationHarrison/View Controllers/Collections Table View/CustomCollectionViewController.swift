//
//  CustomCollectionViewController.swift
//  ShopifyApplicationHarrison
//
//  Created by Harrison U-Ebili  on 2019-01-19.
//  Copyright © 2019 com.Harrisonhcue. All rights reserved.
//

import UIKit

class CustomCollectionViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var collections:[Collection]?
    var selectedCollection:String?
    @IBOutlet var modalView:UIView!
    
    var currentSetProducts = [Product]()
    
    @IBOutlet var tblView:UITableView!
    @IBOutlet var activityIndicator:UIActivityIndicatorView!
   
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("Loading collections")
    }
    
    override func viewDidLoad() {
        
        collections = appDelegate.collection.collections
        
        
        
        super.viewDidLoad()
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return collections!.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell", for: indexPath)
        
        cell.textLabel?.text = collections![indexPath.row].collectionName
        
        // Configure the cell...
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        modalView.isHidden = false
         activityIndicator.isHidden = false
        activityIndicator.startAnimating()
       
       
       
        modalView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let index = indexPath.row
        let cell = tableView.cellForRow(at: indexPath)
        
        tblView.deselectRow(at: indexPath, animated: true)
        
        let collection = collections![index]
        
        currentSetProducts = appDelegate.collection.getCollectionProducts(collectionID: collection.collectionID!)!
        
        currentSetProducts = appDelegate.collection.getProductDetails(products:currentSetProducts, collectionID: collection.collectionID!)
        
        selectedCollection = cell!.textLabel?.text
        
       
        modalView.isHidden = true
        activityIndicator.stopAnimating()
      
        
        self.performSegue(withIdentifier: "showDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let vc = segue.destination as? CollectionDetailsTableViewController
        {
            vc.currentSetProducts = currentSetProducts
            vc.navTitle = selectedCollection
            
            
           
        }
        
    }
    
    
    
  
    
}


extension UIImageView{
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
