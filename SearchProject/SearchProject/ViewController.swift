//
//  ViewController.swift
//  SearchProject
//
//  Created by Paolo Ramos Mendez on 5/19/17.
//  Copyright © 2017 mojix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var searchBarListView: SearchBarListView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: ConfigureView
    func configureView()
    {
        self.searchBarListView = SearchBarListView(frame: ViewUtil.getContainerFrame(self, notificationHeight: 20.0))
        self.view.addSubview(self.searchBarListView)
        self.searchBarListView.dataArray = ["asdf", "rebeca", "lista"]
    }
}

