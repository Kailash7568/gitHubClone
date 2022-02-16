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

    
}

