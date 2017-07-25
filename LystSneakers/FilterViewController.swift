//
//  FilterViewController.swift
//  LystSneakers
//
//  Created by Jaz King on 24/07/2017.
//  Copyright © 2017 Jaz King. All rights reserved.
//


import UIKit
import Spring
import Alamofire
import SwiftyJSON
import LystNetwork

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //UIButton Outlets
    @IBOutlet weak var manButton: DesignableButton!
    @IBOutlet weak var womanButton: DesignableButton!
    @IBOutlet weak var filterButton: DesignableButton!
    @IBOutlet weak var tableView: UITableView!
    
    //network instance passed by Feed view controller
    var networkManager: NetworkManager!
    
    //Categories array for tableview
    var categories: [String] = []
    
    //View Controller UIView Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Remove additonal cells
        tableView.tableFooterView = UIView(frame: .zero)
        
        //Fetch Categories to load into tableview
        fetchCategories()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Cancel changes
    @IBAction func cancelAction(_ sender: Any) {
        
        //Dismiss view controller
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // Button Actions
    @IBAction func manButtonAction(_ sender: Any) {
        
        //Animate button
        animateButtonPopAnimation(manButton)
        
        //Set gender preference
        networkManager.gender = .male
        
        //Fetch categories for gender and reload table view
        fetchCategories()
    }
    
    @IBAction func womanButtonAction(_ sender: Any) {
        
        //Animate button
        animateButtonPopAnimation(womanButton)
        
        //Set gender preference
        networkManager.gender = .female
        
        //Fetch categories for gender and reload table view
        fetchCategories()
    }
    
    @IBAction func applyFiltersAction(_ sender: Any) {
        
        // Set notification and fetch parameters
        let networkInstance:[String: NetworkManager] = ["Network": self.networkManager]
        
        //Post notification to Feed View Controller
        NotificationCenter.default.post(name: Notification.Name(rawValue: "refreshFeed"), object: nil, userInfo: networkInstance)
        
        //Animate Button
        animateButtonPopAnimation(filterButton)
        
        //Dismiss Controller
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func clearFilters(_ sender: Any) {
        
        //Set User Preferences
        networkManager.gender = .none
        networkManager.category = nil
        
        // Set notification and fetch parameters
        let networkInstance:[String: NetworkManager] = ["Network": self.networkManager]
        
        //Post notification
        NotificationCenter.default.post(name: Notification.Name(rawValue: "refreshFeed"), object: nil, userInfo: networkInstance)
        
        //Dismiss view controller
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = categories[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //St preference to category string in table view cell
        self.networkManager.category = categories[indexPath.row]
        
        print("Selected \(categories[indexPath.row])")
    }
    
}


extension FilterViewController {
    
    
    //Set layout for user preferences
    func changeInterfacePreferences() {
        
        switch self.networkManager.gender {
        case .male:
            print("is male")
            self.tableView.isHidden = false
            self.manButton.backgroundColor = UIColor(red:1.00, green:0.51, blue:0.46, alpha:1.0)
            self.manButton.setTitleColor(.white, for: .normal)
            self.womanButton.backgroundColor = UIColor.white
            self.womanButton.setTitleColor(.black, for: .normal)
            self.filterButton.backgroundColor = UIColor(red:1.00, green:0.51, blue:0.46, alpha:1.0)
            self.filterButton.setTitleColor(.white, for: .normal)
            
        case .female:
            self.tableView.isHidden = false
            self.womanButton.backgroundColor = UIColor(red:1.00, green:0.51, blue:0.46, alpha:1.0)
            self.womanButton.setTitleColor(.white, for: .normal)
            self.manButton.backgroundColor = UIColor.white
            self.manButton.setTitleColor(.black, for: .normal)
            self.filterButton.backgroundColor = UIColor(red:1.00, green:0.51, blue:0.46, alpha:1.0)
            self.filterButton.setTitleColor(.white, for: .normal)
            
        case .none:
            self.tableView.isHidden = true
            self.womanButton.backgroundColor = UIColor.white
            self.womanButton.setTitleColor(.black, for: .normal)
            self.manButton.backgroundColor = UIColor.white
            self.manButton.setTitleColor(.black, for: .normal)
            self.filterButton.backgroundColor = UIColor(red:1.00, green:0.51, blue:0.46, alpha:1.0)
            self.filterButton.setTitleColor(.white, for: .normal)
            
        }
    }
    
    //Animate Button
    func animateButtonPopAnimation(_ button: DesignableButton) {
        button.animation = "pop"
        button.curve = "spring"
        button.duration = 1.0
        button.animate()
        
    }
    
    //Fetch categories by preference
    func fetchCategories() {
        
        //Url property
        var stringUrl: String = ""
        
        //Set value using gender preference
        switch self.networkManager.gender {
        case .male:
            //print("is male")
            stringUrl = "https://api.lyst.com/rest_api/components/filter_options/?pre_gender=M&pre_product_type=Shoes&filter_type=category"
            changeInterfacePreferences()
        case .female:
            //print("is female")
            stringUrl = "https://api.lyst.com/rest_api/components/filter_options/?pre_gender=F&pre_product_type=Shoes&filter_type=category"
            changeInterfacePreferences()
        case .none:
            changeInterfacePreferences()
        }
        
        
        // Get categories for gender preference selected
        
        //If gender is not set do not fetch categories else response will return error
        if networkManager.gender != .none {
            DispatchQueue.main.async {
                self.networkManager.getCategories(completionHandler: { list in
                    self.categories = list
                    self.tableView.reloadData()
                    print("Categories in view controller products array \(self.categories.count)")
                    
                }, stringUrl)
            }
        }
        
        //Reload tableview
        self.tableView.reloadData()
        
    }
    
}
