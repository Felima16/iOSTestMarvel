//
//  Utils.swift
//  iOSTestMarvel
//
//  Created by Fernanda de Lima on 15/09/2018.
//  Copyright © 2018 FeLima. All rights reserved.
//

import UIKit

class Utils{
    
    class func convertStringToDate(date: String) -> Date {
        
        let justDate = date.split(separator: "T")
        
        let formatter = DateFormatter()
        
        //get locale
        formatter.timeZone = TimeZone.current
        
        //Get current date
        formatter.dateFormat = "yyyy-MM-dd"
        
        print(justDate[0])
        
        //Date with current date and start time
        let returnDate = formatter.date(from: String(justDate[0]))
        
        return returnDate!

    }
}
