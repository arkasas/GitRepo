//
//  FileController.swift
//  GitRepo
//
//  Created by Arkadiusz Pituła on 01/02/2019.
//  Copyright © 2019 Arkadiusz Pituła. All rights reserved.
//

import Foundation

class FileController {

    private let dir: URL?
    init() {
        dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }

    @discardableResult
    func saveData(data: Data, name: String) -> Bool {
        guard let dir = dir else {
            return false
        }


        let fileUrl = dir.appendingPathComponent(name)
        print(fileUrl)
        do {
            try data.write(to: fileUrl)
            return true
        } catch {
            print(error)
            return false
        }
    }

    func readData(name: String) -> Data? {
        guard let dir = dir else {
            return nil
        }

        let fileUrl = dir.appendingPathComponent(name)
        return try? Data(contentsOf: fileUrl)
    }

}
