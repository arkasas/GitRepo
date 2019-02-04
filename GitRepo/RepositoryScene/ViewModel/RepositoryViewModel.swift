//
//  RepositoryViewModel.swift
//  GitRepo
//
//  Created by Arkadiusz Pituła on 03/02/2019.
//  Copyright © 2019 Arkadiusz Pituła. All rights reserved.
//

import UIKit
import Alamofire

class RepositoryViewModel {
    private var userNetwork = UserNetwork()
    private let fileController = FileController()
    private let decoder = JSONDecoder()

    static let repoCellIdentifier = "userCellIdentifier"

    func fetchRepository(url: String, completion: @escaping (_ repos: [Repository]) -> Void) {
        userNetwork.downloadUserRepository(url: url) { result in
            if result.error != nil {
                self.didCannotDownloadRepos(url: url, completion: completion)
            } else {
                let repos: Result<[Repository]> = self.decoder.decodeResponse(from: result)
                if let data = result.data {
                    let name = self.userNetwork.url.absoluteString.replacingOccurrences(of: "/", with: "_")
                    self.saveData(data, name: name)
                }
                self.didDownloadEnd(with: repos, completion: completion)
            }
        }
    }

    private func didDownloadEnd(with result: Result<[Repository]>, completion: @escaping (_ repos: [Repository]) -> Void) {
        switch result {
        case .success(let value):
            completion(value)
        case .failure:
            completion([])
        }
    }

    private func saveData(_ data: Data, name: String) {
        fileController.saveData(data: data, name: name)
    }

    private func didCannotDownloadRepos(url: String, completion: @escaping (_ repos: [Repository]) -> Void) {
        let name = url.replacingOccurrences(of: "/", with: "_")
        guard
            let data = fileController.readData(name: name),
            let repos = try? decoder.decode([Repository].self, from: data) else {
                completion([])
                return
        }

        completion(repos)
    }


}

final class RepositoryDataSource: NSObject, UITableViewDataSource {

    private var repos: [Repository]

    init(repos: [Repository]) {
        self.repos = repos
    }

    func repo(at indexPath: IndexPath) -> Repository {
        return repos[indexPath.row]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryViewModel.repoCellIdentifier, for: indexPath) as! RepositoryTableViewCell
        cell.repo = repos[indexPath.row]
        return cell
    }
}
