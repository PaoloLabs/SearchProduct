//
//  ViewUtil.swift
//  SearchProject
//
//  Created by Paolo Ramos Mendez on 5/19/17.
//  Copyright © 2017 mojix. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) in
                if data != nil {
                    self.image = UIImage(data: data!)
                }
            })
        }
    }
}

class ViewUtil: UIView {

    
    class func getContainerFrame(viewController: UIViewController) -> CGRect {
        let notificationHeight = CGFloat(20.0)
        return CGRectMake(viewController.view.frame.origin.x,
                          viewController.view.frame.origin.y + viewController.navigationController!.navigationBar.frame.size.height + notificationHeight,
                          viewController.view.frame.width,
                          viewController.view.frame.height - viewController.tabBarController!.tabBar.frame.height - viewController.navigationController!.navigationBar.frame.size.height - notificationHeight)
    }
    
    class func getContainerFrame(viewController: UIViewController, notificationHeight: CGFloat) -> CGRect {
        return CGRectMake(viewController.view.frame.origin.x,
                          viewController.view.frame.origin.y + viewController.navigationController!.navigationBar.frame.size.height + notificationHeight,
                          viewController.view.frame.width,
                          viewController.view.frame.height - viewController.navigationController!.navigationBar.frame.size.height - notificationHeight)
    }
}
