//
//  PersistenceHelper.swift
//  WeatherApp
//
//  Created by casandra grullon on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

enum DataPersistenceError: Error { // conforming to the Error protocol
    case savingError(Error) // associative value
    case fileDoesNotExist(String)
    case noData
    case decodingError(Error)
    case deletingError(Error)
}


class PersistenceHelper {
    
    private var photos = [Picture]()
    private var filename: String
    
    init(filename: String) {
        self.filename = filename
    }
    
    private func save() throws {
        do {
            let url = FileManager.pathToDocumentsDirectory(with: filename)
            print(url)
            let data = try PropertyListEncoder().encode(photos)
            
            try data.write(to: url, options: .atomic)
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    public func reorder(photos: [Picture]) {
        self.photos = photos
        try? save()
    }
    
    public func create(photo: Picture) throws {
        photos.append(photo)
        
        do {
            try save()
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    public func loadPhotos() throws -> [Picture] {
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        if FileManager.default.fileExists(atPath: url.path) {
            if let data = FileManager.default.contents(atPath: url.path) {
                do {
                    photos = try PropertyListDecoder().decode([Picture].self, from: data)
                } catch {
                    throw DataPersistenceError.decodingError(error)
                }
            } else {
                throw DataPersistenceError.noData
            }
        }
        else {
            throw DataPersistenceError.fileDoesNotExist(filename)
        }
        return photos
    }
    
    public func delete(photo index: Int) throws {
        photos.remove(at: index)
        do {
            try save()
        } catch {
            throw DataPersistenceError.deletingError(error)
        }
    }
}
