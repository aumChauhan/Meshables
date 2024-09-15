//
//  USDZFileService.swift
//  Meshables
//
//  Created by Aum Chauhan on 09/09/24.
//

import Foundation

/// A service for handling USDZ file operations and providing functionality to download and save USDZ files.
struct USDZFileService {
    
    // MARK: - PROPERTIES
    
    static let shared = USDZFileService()
    
    // MARK: - INITIALIZER
    
    private init() {}
    
    // MARK: - FILE OPERATIONS
    
    /// Downloads the USDZ file asynchronously and moves it to a specified file path.
    func downloadFileAsync(from url: URL, to destinationURL: URL) async throws -> URL {
        let (tempURL, _) = try await URLSession.shared.download(from: url)
        let fileManager = FileManager.default
        
        // If the file exists, delete it before moving the new one
        if fileManager.fileExists(atPath: destinationURL.path) {
            print("File exists at destination. Removing it: \(destinationURL.path)")
            try fileManager.removeItem(at: destinationURL)
        }
        
        try fileManager.moveItem(at: tempURL, to: destinationURL)
        return destinationURL
    }
    
    /// Fetches the USDZ file and ensures it is either downloaded or fetched from the cache.
    func fetchUSDZFile(usdzURL: URL, cacheURL: URL) async throws -> URL {
        let fileManager = FileManager.default
        
        // Debug logging for the cache URL
        print("Cache file URL: \(cacheURL.path)")
        
        // Check if the file exists in the cache
        if fileManager.fileExists(atPath: cacheURL.path) {
            print("File found in cache. Using cached file: \(cacheURL.path)")
            return cacheURL // Return cached file if it exists
        } else {
            print("File not found in cache. Downloading from: \(usdzURL.absoluteString)")
            return try await downloadFileAsync(from: usdzURL, to: cacheURL) // Download if not present
        }
    }
}
