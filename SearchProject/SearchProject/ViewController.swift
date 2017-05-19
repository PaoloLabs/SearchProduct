//
//  ViewController.swift
//  SearchProject
//
//  Created by Paolo Ramos Mendez on 5/19/17.
//  Copyright © 2017 mojix. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SearchBarListViewDelegate {
    
    var searchBarListView: SearchBarListView!
    class var searchBarText: String { return "searchBarText" }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.searchBarText), name: ViewController.searchBarText, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: ViewController.searchBarText, object: nil)
    }
    
    // MARK: ConfigureView
    func configureView()
    {
        self.searchBarListView = SearchBarListView(frame: ViewUtil.getContainerFrame(self, notificationHeight: 20.0))
        self.searchBarListView.delegate = self
        self.view.addSubview(self.searchBarListView)
    }
    
    
    func didSelectRowAtIndexPathInTableView(stringData: String) {
        print("selecciono \(stringData)")
    }
    
    func searchBarText(notification: NSNotification) {
        if let object = notification.object as? String {
            print("selecciono \(object)")
        }

    }
    
}

