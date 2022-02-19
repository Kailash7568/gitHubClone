//
//  Utilities.swift
//  gitHubProfileProject
//
//  Created by Kailash Jangir on 10/02/22.
//

import Foundation
import UIKit

class Utilities{
    
    //MARK: function to round image
    static func roundImage(imageView: UIImageView){
        imageView.layer.borderWidth = 1.0
        imageView.layer.cornerRadius = imageView.frame.height / 2
    }
    
    //MARK: function to round edges of button
    static func roundButton(button: UIButton){
        button.layer.cornerRadius = 22
    }
    
    //MARK: function to short the number
    static func short(_ num: Int) -> String {
        if num >= 1000 && num < 10000 {
            return String(format: "%.1fK", Double(num/100)/10).replacingOccurrences(of: ".0", with: "")
        }

        if num >= 10000 && num < 1000000 {
            return "\(num/1000)k"
        }

        if num >= 1000000 && num < 10000000 {
            return String(format: "%.1fM", Double(num/100000)/10).replacingOccurrences(of: ".0", with: "")
        }

        if num >= 10000000 {
            return "\(num/1000000)M"
        }

        return String(num)
      }
      
    //MARK: function to get difference of dates
    static func dateDifference(repoDate: String) -> String{

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let now = Date()
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.maximumUnitCount = 2
        
        if let date = dateFormatter.date(from:repoDate){
            let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: now)
            
            let year = components.year ?? 0
            let month = components.month ?? 0
            let day = components.day ?? 0
            let hour = components.hour ?? 0
            let minute = components.minute ?? 0
            let second = components.second ?? 0
            
            if(year > 0){
                return (year == 1) ? "Updated" + String(year) + " year ago" : "Updated" + String(year) + " years ago"
            }else if(month > 0){
                return (month == 1) ? "Updated" + String(month) + " month ago" : String(month) + " months ago"
            }else if(day > 0){
                return (day == 1) ? "Updated" + String(day) + " day ago" : String(day) + " days ago"
            }else if(hour > 0){
                return (hour == 1) ? "Updated" + String(hour) + " hour ago" : String(hour) + " hours ago"
            }else if(minute > 0){
                return (minute == 1) ? "Updated" + String(minute) + " minute ago" : String(minute) + " minutes ago"
            }else if(second > 0){
                return (second == 1) ? "Updated" + String(second) + " second ago" : String(second) + " seconds ago"
            }
        }
            return ""
        
    }
    
}


