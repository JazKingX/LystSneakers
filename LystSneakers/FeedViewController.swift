//
//  FeedViewController.swift
//  LystSneakers
//
//  Created by Jaz King on 24/07/2017.
//  Copyright © 2017 Jaz King. All rights reserved.
//

import UIKit
import Spring
import Kingfisher
import LystNetwork

class FeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //UI Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterButton: DesignableButton!
    @IBOutlet weak var sortButton: DesignableButton!
    
    //Properties
    var networkManager = NetworkManager()
    var products: Array = [Product]()
    var sortBy: Int = 1
    
    
    //View Controller UIView Lifecylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Add notification observer
        NotificationCenter.default.addObserver(self, selector: #selector(FeedViewController.refreshFeed(_:)), name:NSNotification.Name(rawValue: "refreshFeed"), object: nil)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Button Actions
    
    //Sort Button
    @IBAction func sortAction(_ sender: Any) {
        
        //Animation for action
        animateButtonPopAnimation(sortButton)
        
        //Update sortBy property value
        //Sort products in collection view
        if self.sortBy == 0 {
            self.sortBy = 1
            sortProducts(true)
        } else if self.sortBy == 1 {
            self.sortBy = 0
            sortProducts(false)
        }
        
    }
    
    
    
    // Filter Button
    @IBAction func filterAction(_ sender: Any) {
        
        //Animation for action
        animateButtonPopAnimation(filterButton)
        
        //perform segue to filter view controller
        performSegue(withIdentifier: "showFilters", sender: self)
        
    }
    
    
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return the number of items in products array
        return self.products.count
    }
    
    //Configure collection view cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        // Configure the cell
        
        //Get image url as string from products array
        let imageUrl = (self.products[(indexPath as NSIndexPath).row] ).imageUrl
        
        //Add Indicator to cell
        cell.cellImage.kf.indicatorType = .activity
        
        //Set image with url
        let url = URL(string: imageUrl)!
        cell.cellImage.kf.setImage(with: url, options: [.transition(.fade(0.2))])
        
        //Set cell text labels
        cell.titleLabel.text = (self.products[(indexPath as NSIndexPath).row] ).designerName
        cell.detailLabel.text = (self.products[(indexPath as NSIndexPath).row] ).title
        cell.priceLabel.text = (self.products[(indexPath as NSIndexPath).row] ).price
        
        //return cell
        return cell
    }
    
    //If user selects cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //initiate a segue to detail view
        
        //Store product properties to use for notification when app enters background
        
        //Print product details to the console
        print("Selected \(self.products[(indexPath as NSIndexPath).row].designerName), \(self.products[(indexPath as NSIndexPath).row].title)")
    }
    
    //Cell Size
    func collectionView(_ collectionView: UICollectionView,  layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        // Create size property
        var size: CGSize!
        
        //Get device size width
        let screenWidth = self.view.frame.width
        
        //Handle user device and set cell size
        switch UIDevice().model {
        case "iPhone":
            if UIDevice.current.orientation.isPortrait == true {
                size = CGSize(width: screenWidth / 2.2, height: screenWidth / 1.5 )
            } else if UIDevice.current.orientation.isLandscape == true {
                size = CGSize(width: screenWidth / 3.3, height: screenWidth / 2.5)
            }
        case "iPad":
            size = CGSize(width: screenWidth / 4.5, height: screenWidth / 3.2 )
        default:
            size = CGSize(width: screenWidth / 3.2, height: screenWidth / 1.5 )
        }
        
        
        //Return cell size
        return size
    }
    
    //Use for interspacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 15.0
    }
    
    
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFilters" {
            let controller = (segue.destination as! UINavigationController).topViewController as! FilterViewController
            controller.networkManager = self.networkManager
        }
    }
    
}

extension FeedViewController {
    
    //Animate button
    func animateButtonPopAnimation(_ button: DesignableButton) {
        
        button.animation = "pop"
        button.curve = "spring"
        button.duration = 1.0
        button.animate()
        
    }
    
    //Refresh feed for notification handler
    func refreshFeed(_ notification: Notification){
        if let network = notification.userInfo?["Network"] as? NetworkManager {
            self.networkManager = network
            // print("Refresh Feed")
            loadData()
        }
    }
    
    // Sort Products by price
    func sortProducts(_ ascending: Bool) {
        
        //Sort products in order by designerName
        switch ascending {
        case true:
            self.products.sort { $0.designerName > $1.designerName  }
        case false:
            self.products.sort { $0.designerName < $1.designerName  }
        }
        self.collectionView.reloadData()
        
    }
    
    
    // Load products from url
    func loadData() {
        DispatchQueue.main.async {
            self.networkManager.getObjects(completionHandler: { list in
                self.products = list
                self.collectionView.reloadData()
                // print("Products in view controller products array \(self.products.count)")
                
            }, self.networkManager.getUrl(self.networkManager.gender, category: self.networkManager.category))
        }
    }
    
}
