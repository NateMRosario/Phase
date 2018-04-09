//
//  Date+TimeAgoDisplay.swift
//  Phase
//
//  Created by C4Q on 3/21/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        let year = 12 * month
        
        var quotient: Int
        var unit: String
        
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = "second"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "min"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "hour"
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "day"
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = "week"
        } else if secondsAgo < year {
            quotient = secondsAgo / month
            unit = "month"
        } else {
            quotient = secondsAgo / year
            unit = "year"
        }
        return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
    }
    
    func convertDateToString(from num: NSNumber?) -> String? {
        guard num != nil else {return nil}
        let numAsDate = Date(timeIntervalSinceReferenceDate: num as! TimeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.string(from: numAsDate)
    }
    
    func getCurrentDateTime() -> String {
        let currentDateTime = Date().timeIntervalSinceReferenceDate
        return convertDateToString(from: currentDateTime as NSNumber)!
    }
    
    func timePosted(from num: NSNumber?) -> String? {
        guard let timePosted = (convertDateToString(from: num)) else { return nil}
        let currentTime = getCurrentDateTime()
        
        let Dateformatter = DateFormatter()
        Dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let date1 = Dateformatter.date(from: timePosted) else { return nil }
        let date2 = Dateformatter.date(from: currentTime)
        
        let distanceBetweenDates: TimeInterval? = date2?.timeIntervalSince(date1)
        
        let secondsinAMinute: Double = 60
        let secondsInAnHour: Double = 3600
        let secondsInDays: Double = 86400
        let secondsInWeek: Double = 604800
        guard let distanceBetweenDatesGuarded = distanceBetweenDates else { return nil }
        
        let minutesBetweenDates = Int((distanceBetweenDatesGuarded / secondsinAMinute))
        let hoursBetweenDates = Int((distanceBetweenDatesGuarded / secondsInAnHour))
        let daysBetweenDates = Int((distanceBetweenDatesGuarded / secondsInDays))
        let weekBetweenDates = Int((distanceBetweenDatesGuarded / secondsInWeek))
        
//        let calculatedTime = Int(distanceBetweenDates!)
        
        switch fabs(distanceBetweenDatesGuarded) {
        case 0..<60:
            return "\(distanceBetweenDatesGuarded) seconds ago" // seconds
        case 60..<3600:
            return "\(minutesBetweenDates) minutes ago" // minutes
        case 3600..<86400:
            return "\(hoursBetweenDates) hours ago" // hours
        case 86400..<172800:
            return "\(daysBetweenDates) day ago" // day
        default:
            return "\(daysBetweenDates) days ago" // days
        }
        
//        let convertedPostedTime = (hoursBetweenDates > 24) ? "\(hoursBetweenDates)" : "\(daysBetweenDates)"
        
//        print(distanceBetweenDates, "distance between dates")
//        print(minutesBetweenDates, "seconds")
//        print(weekBetweenDates,"weeks")//0 weeks
//        print(daysBetweenDates,"days")//5 days
//        print(hoursBetweenDates,"hours")//120 hours
//        print("convertedPostedTime: \(convertedPostedTime)")
    }
}

