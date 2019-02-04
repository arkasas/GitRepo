//
//  BaseNetwork.swift
//  GitRepo
//
//  Created by Arkadiusz Pituła on 03/02/2019.
//  Copyright © 2019 Arkadiusz Pituła. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case unknowError
}

class BaseNetwork {

    var api: String {
        return "https://api.github.com/"
    }

    var router: String {
        return ""
    }

    var url: URL {
        return URL(string: api + router)!
    }

}
