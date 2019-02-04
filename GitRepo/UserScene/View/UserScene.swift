//
//  UserScene.swift
//  GitRepo
//
//  Created by Arkadiusz Pituła on 02/02/2019.
//  Copyright © 2019 Arkadiusz Pituła. All rights reserved.
//

import UIKit

class UserScene: UIViewController {

    @IBOutlet private var tableView: UITableView!
    private var viewModel: UserViewModel = UserViewModel()
    private var userDataSource: GithubUserDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchUsers()
    }

    @IBAction private func refresh() {
        fetchUsers()
    }

    private func setupTableView() {
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: UserViewModel.userCellIdentifier)
        tableView.delegate = self
    }

    private func fetchUsers() {
        viewModel.fetchUsers { users in
            self.didDownloadUsers(users)
        }
    }

    private func didDownloadUsers(_ users: [User]) {
        userDataSource = generateDataSource(from: users)
        DispatchQueue.main.async {
            self.tableView.dataSource = self.userDataSource
            self.tableView.reloadData()
        }
    }

    private func generateDataSource(from users: [User]) -> GithubUserDataSource {
        return GithubUserDataSource(users: users)
    }

    private func repoScene(for user: User) -> RepositoryScene {
        let repoScene = UIStoryboard(name: "RepositoryScene", bundle: nil).instantiateInitialViewController() as! RepositoryScene
        repoScene.user = user
        return repoScene
    }
}

extension UserScene: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let user = userDataSource?.user(at: indexPath) else { return }
        navigationController?.pushViewController(repoScene(for: user), animated: true)
    }
}
