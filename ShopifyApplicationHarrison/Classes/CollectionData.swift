//
//  Collection.swift
//  ShopifyApplicationHarrison
//
//  Created by Harrison U-Ebili  on 2019-01-19.
//  Copyright © 2019 com.Harrisonhcue. All rights reserved.
//

import UIKit

class CollectionData: NSObject {
    
    var collections :[Collection] = []
    
    var productDetails:JSON?
    
    let access_token :String = "c32313df0d0ef512ca64d5b336a0d7c6"
    let page:Int = 1
    
    
    internal let URL_COLLECTIONS = "https://shopicruit.myshopify.com/admin/custom_collections.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
    
    internal let URL_COLLECTION_PRODUCTS = "https://shopicruit.myshopify.com/admin/collects.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6&"
    
    internal let URL_PRODUCT_DETAILS = "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6&"
    
    
    //Retrieves entire JSON OBJECT of collections as APP loads
    func getCollections()
    {
        var finished = false
        collections.removeAll()
        
        let group = DispatchGroup()
        group.enter()
        
        
        let url = URL(string: URL_COLLECTIONS)
        let request = URLRequest(url: url!)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else { return }
            do {
                let result = try JSON(data:data)
                
                let collectionJSON = result["custom_collections"]
                for col in collectionJSON
                {
                    let collection = Collection()
                    
                    collection.collectionID = Int(col.1["id"].stringValue)
                    collection.collectionName = col.1["title"].stringValue
                    
                    let collectionImg = CollectionImage()
                    collectionImg.url =  col.1["image"]["src"].stringValue
                    
                    collectionImg.width = Int(col.1["image"]["width"].stringValue)
                    collectionImg.height = Int(col.1["image"]["height"].stringValue)
                    //collection.collectionImageUrl = collectionImg
                    
                    
                    self.collections.append(collection)
                    
                    if (collectionJSON[collectionJSON.count - 1] == col.1)
                    {
                        finished = true
                    }
                    
                }
                
                
                
                
            }
            catch{
                print("An error has occured while serializing data")
                finished = true
                
            }
            
            repeat {
                RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
            } while !finished
            
            return
            
            }.resume()
        
    }
    
    func getCollectionProducts(collectionID:Int) -> [Product]?
    {
        var finished = false
        let id = String(collectionID)
        
        var collectionProducts = [Product]()
        
        let url = URL(string: "\(URL_COLLECTION_PRODUCTS)collection_id=\(id)")
        
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            do {
                
                let result = try JSON(data:data)
                let collects = result["collects"]
                
                for item in collects
                {
                    
                    
                    let productID = Int(item.1["product_id"].stringValue)
                    let collectionID = Int(item.1["collection_id"].stringValue)
                    
                    let product = Product()
                    product.collectionID = collectionID
                    product.productId = productID
                    
                    collectionProducts.append(product)
                    
                    if (collects[collects.count - 1 ] == item.1)
                    {
                        finished = true
                        
                    }
                }
                
                
            }
            catch
            {
                print("An error has occured while serializing data")
                
            }
            
            
            
            }.resume()
        repeat {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        } while !finished
        return collectionProducts
        
    }
    
    
    //
    func getProductDetails(products:[Product],collectionID:Int) -> [Product]
    {
        var collectionProducts:[Product] = [Product]()
        var idString = ""
        for prod in products
        {
            
            idString += "\(String(prod.productId!)),"
            
        }
        
        var finished = false
        
        let url = URL(string: "\(URL_PRODUCT_DETAILS)&ids=\(idString)")
        let request = URLRequest(url: url!)
        
        
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else { return }
            do {
                let result = try JSON(data:data)
                let products = result["products"]
                
                for item in products
                {
                    
                    
                    let productID = Int(item.1["id"].stringValue)
                    let title = item.1["title"].stringValue
                    let prodType = item.1["product_type"].stringValue
                    let imageURL = item.1["image"]["src"].stringValue
                    let imgWidth =  Int(item.1["image"]["width"].stringValue)
                    let imgHeight = Int(item.1["image"]["height"].stringValue)
                    let variantCount = item.1["variants"]
                    
                    var prodCount = 0
                    
                    for count in variantCount
                    {
                        prodCount +=  Int(count.1["inventory_quantity"].stringValue)!
                    }
                    
                    
                    
                    let product = Product()
                    product.collectionID = collectionID
                    product.productId = productID
                    product.name = title
                    product.type = prodType
                    product.qty = prodCount
                    
                    
                    
                    //collectionImg.url = imageURL
                    product.imgUrl = imageURL
                    product.imgWidth = imgWidth
                    product.imgHeight = imgHeight
                    
                    collectionProducts.append(product)
                    
                    if (products[products.count - 1 ] == item.1)
                    {
                        finished = true
                        
                    }
                }
                
                
            }
            catch{
                
            }
            
            }.resume()
        repeat {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        } while !finished
        
        
        return collectionProducts
    }
    
}




