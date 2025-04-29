//
//  DiskCacheProtocol.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/27/25.
//
import SwiftUI

protocol ImageCacheProtocol {
    func write(data: Data, url: URL) async throws
    func read(url: URL) async throws -> UIImage?
}
