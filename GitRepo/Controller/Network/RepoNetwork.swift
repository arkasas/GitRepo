//
//  RepoController.swift
//  GitRepo
//
//  Created by Arkadiusz Pituła on 03/02/2019.
//  Copyright © 2019 Arkadiusz Pituła. All rights reserved.
//

import Foundation

class RepoNetwork: BaseNetwork {

    override var router: String {
        return "users"
    }

    func downloadGithubUsers(completion: @escaping(_ result: Result<[User]>) -> Void) {
        Alamofire
            .request(url, method: .get)
            .responseData { response in
                let decoder = JSONDecoder()
                let users: Result<[User]> = decoder.decodeResponse(from: response)
                completion(users)
        }
    }


}
