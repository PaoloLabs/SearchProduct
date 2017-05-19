//
//  ViewController.swift
//  SearchProject
//
//  Created by Paolo Ramos Mendez on 5/19/17.
//  Copyright © 2017 mojix. All rights reserved.
//

import UIKit
import MRProgress
import Alamofire

class ViewController: UIViewController, SearchBarListViewDelegate {
    
    var searchBarListView: SearchBarListView!
    class var searchBarText: String { return "searchBarText" }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        self.consumeService()
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
    
    func consumeService() {
        
        
        let url: NSString = "https://www.liverpool.com.mx/tienda?s=computadora&d3106047a194921c01969dfdec083925=json"
        let urlStr: NSString = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let searchURL: NSURL = NSURL(string: String(urlStr))!
        let request = NSMutableURLRequest(URL: searchURL)
        Alamofire.request(request).responseJSON { (response) in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
//            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
        
//        
//        getRequestAccordingToMethod
//        
//        self.re
//        Alamofire.request("https://httpbin.org/get").responseJSON { response in
//            print(response.request)  // original URL request
//            print(response.response) // HTTP URL response
//            print(response.data)     // server data
//            print(response.result)   // result of response serialization
//            
//            if let JSON = response.result.value {
//                print("JSON: \(JSON)")
//            }
//        }
//        MRProgressOverlayView.showOverlayAddedTo(self.view, animated: true)
//        sleep(5)
//        MRProgressOverlayView.dismissOverlayForView(self.view, animated: false)
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

