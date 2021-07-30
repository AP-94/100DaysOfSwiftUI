//
//  FileManager+SaveData.swift
//  iForgetNames
//
//  Created by Alessandro Pace on 28/7/21.
//

import Foundation

extension FileManager {
    
    func decode<T: Codable>(_ file: String) -> T {
        let url = getDocumentsDirectory().appendingPathComponent(file)
        let decoder = JSONDecoder()
        
        guard let data = try? Data(contentsOf: url), let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to load \(file) from documents directory.")
        }

        return loaded
    }
    
    func encode<T: Codable>(_ object: T, _ file: String) {
        let url = getDocumentsDirectory().appendingPathComponent(file)
        let encoder = JSONEncoder()

        guard let data = try? encoder.encode(object) else {
            fatalError("Failed encode object")
        }
        
        do {
            try data.write(to: url, options: .atomic)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
