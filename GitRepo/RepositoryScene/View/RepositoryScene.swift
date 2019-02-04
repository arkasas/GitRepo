//
//  RepositoryScene.swift
//  GitRepo
//
//  Created by Arkadiusz Pituła on 03/02/2019.
//  Copyright © 2019 Arkadiusz Pituła. All rights reserved.
//

import UIKit

class RepositoryScene: UIViewController {

    @IBOutlet private var tableView: UITableView!
    private let viewModel = RepositoryViewModel()
    private var repoDataSource: RepositoryDataSource?

    var user: User! {
        didSet {
            title = user.login
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchRepos()
    }

    @IBAction private func refresh() {
        fetchRepos()
    }

    private func setupTableView() {
        tableView.register(UINib(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: RepositoryViewModel.repoCellIdentifier)
        tableView.delegate = self
    }

    private func fetchRepos() {
        viewModel.fetchRepository(url: user.reposURL) { repos in
            self.didDownloadRepos(repos)
        }
    }

    private func didDownloadRepos(_ repos: [Repository]) {
        repoDataSource = generateDataSource(from: repos)
        DispatchQueue.main.async {
            self.tableView.dataSource = self.repoDataSource
            self.tableView.reloadData()
        }
    }

    private func generateDataSource(from repos: [Repository]) -> RepositoryDataSource {
        return RepositoryDataSource(repos: repos)
    }

}

extension RepositoryScene: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let url = URL(string: repoDataSource?.repo(at: indexPath).htmlURL ?? "") else { return }
        UIApplication.shared.open(url)
    }
}
