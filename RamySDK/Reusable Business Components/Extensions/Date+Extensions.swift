//
//  Date+Extensions.swift
//  SQ10
//
//  Created by Ahmed Ramy on 03/11/2021.
//

import Foundation

public enum DateFormat: String, CaseIterable {
    case ddMMyyyySlashed = "dd/MM/yyyy" // "18/10/1993"
    case mmDDyyyySlashed = "MM/dd/yyyy" // "18/10/1993"
    case ddMMyyyyDashed = "dd-MM-yyyy" // "18-10-1993"
    case yyyyMMddDashed = "yyyy-MM-dd" // "1993-10-18"
    case isoMilliSecondsFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // 2020-09-17 07:41:51 +0000
    case ddMMyyyyDotted = "dd.MM.yyyy" // "17.09.2020"
    case isoFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // 2021-03-22T04:08:00Z
    case ddMMyyyyHHmm = "dd MMMM yyyy - hh:mm" // 17 September 2020 - 09:41
    case ddMMyyyyHHmma = "dd MMMM yyyy - hh:mm a" // 17 September 2020 - 09:41 AM
    case hhmmA = "hh:mm a" // 09:59 PM
    case hmmA = "h:mm a" // 9:59 PM
    case mmss = "mm:ss" // 9:59 PM
    case deliveryTypeFormatForDate = "EEEE" // Tuesday
    case deliveryTypeFormatForHour = "HH:mm" // 14:45
    case HHmmss = "HH:mm:ss"
    case yyyyMMddHHmmSS = "yyyy-MM-dd HH:mm:ss"
    case isoMilliSecondsFormatV2 = "yyyy-MM-dd'T'HH:mm:ssZZZ" // 2021-03-09T14:27:21Z
}

public extension Date {
    func format(with formatValue: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatValue.rawValue
        let dateString = dateFormatter.string(from: self)
        return dateString
    }

    static var now: Date {
        .init()
    }
}

public extension String {
    /// The method loops over the currently supported formats and picks the suitable one
    /// Then returns a String with the format that the UI requires
    /// - Parameter requiredFormat: the format that the caller needs
    /// - Returns: Localized Formatted Date
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let suitableFormat = DateFormat
            .allCases
            .first { (possibleFormat: DateFormat) -> Bool in
                dateFormatter.dateFormat = possibleFormat.rawValue
                return dateFormatter.date(from: self) != nil
            }?.rawValue ?? ""

        dateFormatter.dateFormat = suitableFormat
        return dateFormatter.date(from: self) ?? Date()
    }
}
