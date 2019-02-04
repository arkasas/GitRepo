//
//  ImageDownloadController.swift
//  GitRepo
//
//  Created by Arkadiusz Pituła on 04/02/2019.
//  Copyright © 2019 Arkadiusz Pituła. All rights reserved.
//

import Foundation

class ImageDownloadController {

    private var urls: [String]
    private let fileController = FileController()
    init(urls: [String]) {
        self.urls = urls
        startDownload()
    }

    private func startDownload() {
        for url in urls {
            download(from: url)
        }
    }

    func download(from url: URL, save: Bool = false) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil
                else { return }

                self.saveImage(data: data, name: url.absoluteString.replacingOccurrences(of: "/", with: "_"))
            }.resume()
    }
    func download(from link: String) {
        guard let url = URL(string: link) else { return }
        download(from: url)
    }

    private func saveImage(data: Data, name: String) {
        fileController.saveData(data: data, name: name)
    }

}
