//
//  Date+Ext.swift
//  Hoat Ha
//
//  Created by Brian Ha on 5/9/17.
//  Copyright © 2017 HocKey Run. All rights reserved.
//

import Foundation

extension Date {
  static func date(from string: String?) -> Date? {
    guard string != nil else {
      return nil
    }
    
    let formater = DateFormatter()
    formater.locale = Locale(identifier: "en_US_POSIX")
    formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    return formater.date(from: string!)
  }
  
  static func dateComponent(startDate: Date, endDate: Date) -> DateComponents {
    let unitFlags = Set<Calendar.Component>([.day, .hour, .minute, .year])
    return Calendar.current.dateComponents(unitFlags, from: startDate, to: endDate)
  }
  
  static func timeAgo(dateComponent component: DateComponents) -> String {
    guard let day = component.day,
      let hour = component.hour,
      let minute = component.minute else {
        return ""
    }
    if (day == 0 && hour == 0) {
      if (minute == 59) {
        return "1 hr ago"
      }
      if minute != 0 {
        return "\(minute) \((minute > 1 ? "mins ago" : "min ago"))"
      }
      return "now"
    }else if (day == 0 && hour > 0) {
      return "\(hour) \((hour > 1 ? "hrs ago" : "hr ago"))"
    }else {
      if (day >= 365) {
        guard let year = component.year else {
            return "- year"
        }
        return "\(year) \((year > 1 ? "yrs ago" : "yr ago"))"
      }else if (day > 0) {
        return "\(day) \((day > 1 ? "days ago" : "day ago"))"
      }
    }
    return "now"
  }
}
