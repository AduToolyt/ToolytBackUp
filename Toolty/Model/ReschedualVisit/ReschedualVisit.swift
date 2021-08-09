//
//  ReschedualVisit.swift
//  Toolty
//
//  Created by Chirag Patel on 23/07/21.
//

import Foundation
import UIKit

enum EnumReschedualVisit{
    case btnCell
    case calenderCell
    case timeCell
    case locationCell
    case alongCell
    
    var cellId : String{
        switch self{
        case .btnCell:
            return "cell"
        case .calenderCell:
            return "calanderCell"
        case .timeCell:
            return "timeCell"
        case .locationCell:
            return "locationCell"
        case .alongCell:
            return "addCell"
        }
    }
    
    var cellHeight : CGFloat{
        switch self{
        case .btnCell:
            return UITableView.automaticDimension
        case .calenderCell:
            return 250.widthRatio
        case .timeCell:
            return 60.widthRatio
        case .locationCell:
            return 270.widthRatio
        case .alongCell:
            return 250.widthRatio
        }
    }
}
