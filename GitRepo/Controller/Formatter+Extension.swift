//
//  FormatterExtension.swift
//  CoreExtension
//
//  Created by Arkadiusz Pituła on 06/11/2018.
//  Copyright © 2018 Arkadiusz Pituła. All rights reserved.
//

import Foundation

public extension Formatter {
    static public let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current

        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxxxx"
        return formatter
    }()

    static public let short: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()

}
