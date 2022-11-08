//
//  PersistenceManager.swift
//  Country
//
//  Created by Shalom (Xerxes) Owolabi on 07/11/2022.
//

import Foundation
import OSLog

// this protocol was particularly needed when testing. Mocking the PersistenceManager enabled the testing of the ViewModel
// this protocol can be extended to show if the files already exist etc
/// Protocol to manage information saved with the file manager
protocol FileManagerServiceProtocol {
    func persistData(dataToSave: Data, path: URLExtensions)
    func loadPersistedData(path: URLExtensions) -> Data?
}

// Instace of FileManagerServiceProtocol, where the data save is done.
struct PersistenceManager: FileManagerServiceProtocol {
    private static func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    /// Save data "data to Save" to a file path
    func persistData(dataToSave: Data, path: URLExtensions) {
        let file = PersistenceManager.documentsDirectory().appendingPathComponent(path.rawValue)
        do {
            try dataToSave.write(to: file)
            os_log("Data successfully saved.", log: OSLog.default, type: .info)
        } catch let errors{
            print(errors, "mana")
            os_log("Failed to save information...", log: OSLog.default, type: .error)
        }
    }
    /// load data stored at the path. The data is an optional return value.
    func loadPersistedData(path: URLExtensions) -> Data? {
        let filePath = PersistenceManager.documentsDirectory().appendingPathComponent(path.rawValue)
        do {
            let loadedData = try Data(contentsOf: filePath)
            return loadedData
        } catch let errors{
            print(errors)
            os_log("Failure to load information...", log: OSLog.default, type: .error)
        }
        return nil
    }
}

