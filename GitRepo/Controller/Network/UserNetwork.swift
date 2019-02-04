//
//  UserNetwork.swift
//  GitRepo
//
//  Created by Arkadiusz Pituła on 03/02/2019.
//  Copyright © 2019 Arkadiusz Pituła. All rights reserved.
//

import Foundation
import Alamofire

class UserNetwork: BaseNetwork {

    override var router: String {
        return "users"
    }

    func downloadGithubUsers(completion: @escaping(_ result: DataResponse<Data>) -> Void) {
        Alamofire
            .request(url, method: .get)
            .responseData { response in
                completion(response)
        }
    }

    func downloadUserRepository(url: String, completion: @escaping(_ result: DataResponse<Data>) -> Void) {
        Alamofire
            .request(url, method: .get)
            .responseData { response in
                completion(response)
        }
    }

}
