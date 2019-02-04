//
//  DateExtension.swift
//  GitRepo
//
//  Created by Arkadiusz Pituła on 03/02/2019.
//  Copyright © 2019 Arkadiusz Pituła. All rights reserved.
//

import Foundation

public extension Date {
    public var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
    
    public var short: String {
        return Formatter.short.string(from: self)
    }

}
