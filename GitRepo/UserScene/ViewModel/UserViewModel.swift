//
//  UserViewModel.swift
//  GitRepo
//
//  Created by Arkadiusz Pituła on 03/02/2019.
//  Copyright © 2019 Arkadiusz Pituła. All rights reserved.
//

import UIKit
import Alamofire

class UserViewModel {

    private var userNetwork = UserNetwork()
    private let fileController = FileController()
    private var imageDownloadController: ImageDownloadController?
    private let decoder = JSONDecoder()

    static let userCellIdentifier = "userCellIdentifier"

    func fetchUsers(completion: @escaping (_ user: [User]) -> Void) {
        userNetwork.downloadGithubUsers { result in
            if result.error != nil {
                self.didCannotDownloadUsers(completion: completion)
            } else {
                let users: Result<[User]> = self.decoder.decodeResponse(from: result)
                if let data = result.data {
                    let name = self.userNetwork.url.absoluteString.replacingOccurrences(of: "/", with: "_")
                    self.saveData(data, name: name)
                }
                self.didDownloadEnd(with: users, completion: completion)
            }
        }
    }

    private func didDownloadEnd(with result: Result<[User]>, completion: @escaping (_ user: [User]) -> Void) {
        switch result {
        case .success(let value):
            self.downloadAvatars(urls: value.map { return $0.avatarURL })
            completion(value)
        case .failure:
            completion([])
        }
    }

    private func saveData(_ data: Data, name: String) {
        fileController.saveData(data: data, name: name)
    }

    private func downloadAvatars(urls: [String]) {
        imageDownloadController = ImageDownloadController(urls: urls)
    }

    private func didCannotDownloadUsers(completion: @escaping (_ user: [User]) -> Void) {
        let name = self.userNetwork.url.absoluteString.replacingOccurrences(of: "/", with: "_")
        guard
            let data = fileController.readData(name: name),
            let users = try? decoder.decode([User].self, from: data) else {
                completion([])
                return
            }

        completion(users)
    }
}

final class GithubUserDataSource: NSObject, UITableViewDataSource {

    private var users: [User]


    init(users: [User]) {
        self.users = users
    }

    func user(at indexPath: IndexPath) -> User {
        return users[indexPath.row]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserViewModel.userCellIdentifier, for: indexPath) as! UserTableViewCell
        cell.userName = users[indexPath.row].login

        if let data = FileController().readData(name: users[indexPath.row].avatarURL.replacingOccurrences(of: "/", with: "_")) {
            cell.avatar = UIImage(data: data)
        } else {
            cell.avatarURL = users[indexPath.row].avatarURL
        }
        return cell
    }

}
