//
//  SearchBarList.swift
//  vizix-ios-project
//
//  Created by Paolo Ramos on 7/18/16.
//  Copyright © 2016 Mojix. All rights reserved.
//

import UIKit

protocol SearchBarListViewDelegate: class {
    func didSelectRowAtIndexPathInTableView(stringData: String)
}

class SearchBarListView: UIView, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let nibName = "SearchBarListView"
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: SearchBarListViewDelegate?
    var dataArray = [String]()
    var filterArray = [String]()
    var dictionaryKey = String()
    var JSONkeyFilter = String()
    var isJSONdataControl = false
    var searchActive = false
    var checkControl = String()
    var sectionTitle = String()
    
    // MARK: View Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.xibSetup()
    }
    
    func xibSetup() {
        self.view = loadViewFromNib()
        self.view.frame = bounds
        self.view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        self.addSubview(self.view)
        self.configureView()
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    func configureView(){
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.tableView.hidden = true
        self.checkControl.removeAll()
    }
    
    // MARK: Class Methods
    func reloadSearchBarList(stringArrayData: [String], checkControl: String){
        self.checkControl = checkControl
        self.JSONkeyFilter.removeAll()
        self.dataArray = stringArrayData
        self.isJSONdataControl = false
        self.tableView.reloadData()
    }
    
    // MARK: Table View Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            if self.searchActive{
                return self.filterArray.count
            }
            return self.dataArray.count

        }
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1{
            return self.sectionTitle
        }
        return String()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        if indexPath.section == 0 {
            cell.textLabel?.text = "None"
            cell.accessoryType = .None
            if self.checkControl.isEmpty{
                cell.accessoryType = .Checkmark
            }
            return cell
        }
        
        if indexPath.section == 1 {
            if self.searchActive{
                cell.textLabel?.text = self.filterArray[indexPath.row]
            }
            else{
                cell.textLabel?.text = self.dataArray[indexPath.row]
            }
            cell.accessoryType = .None
            if !self.checkControl.isEmpty && cell.textLabel?.text == self.checkControl{
                cell.accessoryType = .Checkmark
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0{
            self.delegate?.didSelectRowAtIndexPathInTableView(String())
        }
        else {
            self.searchBar.resignFirstResponder()
            let data: String
            if self.searchActive {
                data = self.filterArray[indexPath.row]
            }
            else{
                data = self.dataArray[indexPath.row]
            }
            self.delegate?.didSelectRowAtIndexPathInTableView(data)
            self.searchBar.text = data
        }
        self.tableView.hidden = true
    }
    
    // MARK: Search Bar Methods
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            dispatch_async(dispatch_get_main_queue()) {
                self.searchBar.resignFirstResponder()
                self.tableView.hidden = true
            }
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterArray = self.dataArray.filter({ (item) -> Bool in
            let range =  NSString(string: item).rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        self.searchActive = !searchText.isEmpty
        self.tableView.reloadData()
        self.tableView.hidden = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.tableView.reloadData()
        self.tableView.hidden = true
    }
}