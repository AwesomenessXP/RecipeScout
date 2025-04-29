//
//  DiskCacheError.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/27/25.
//

import Foundation

enum ImageCacheError: Error {
    case unableToWrite(Error)
    case unableToRead(Error)
    case unableToDelete(Error)
    case notAnImage
    case invalidURL
    
    var localizedDescription: String {
        switch self {
        case .unableToWrite:
            return "Unable to write data to disk cache."
        case .unableToRead:
            return "Unable to read data from disk cache."
        case .notAnImage:
            return "Data is not an image."
        case .unableToDelete:
            return "Unable to delete data from disk cache."
        case .invalidURL:
            return "URL is invalid."
        }
    }
}
