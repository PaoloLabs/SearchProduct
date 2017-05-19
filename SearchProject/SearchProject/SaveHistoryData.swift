//
//  SaveHistoryData.swift
//  SearchProject
//
//  Created by Paolo Ramos Mendez on 5/19/17.
//  Copyright © 2017 mojix. All rights reserved.
//

import UIKit

class SaveHistoryData: NSObject {
    class func getArrayData() -> [String] {
        return NSUserDefaults.standardUserDefaults().objectForKey("historyArray") as? [String] ?? [String]()
    }
    
    class func setArrayData(array: [String]) {
        NSUserDefaults.standardUserDefaults().setObject(array, forKey: "historyArray")
    }

    class func addDataHistory(data: String) {
        var arrayData = SaveHistoryData.getArrayData()
        var controlData = true
        for item in arrayData {
            if item == data {
                controlData = false
                break
            }
        }
        if controlData {
            arrayData.append(data)
            SaveHistoryData.setArrayData(arrayData)
        }
    }

}
