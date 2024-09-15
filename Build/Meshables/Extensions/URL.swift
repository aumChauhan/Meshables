//
//  URL.swift
//  Meshables
//
//  Created by Aum Chauhan on 09/09/24.
//

import Foundation

extension URL {
    
    /// Computes a URL for caching a USDZ file based on the current URL.
    ///
    /// - Returns: The computed cache URL for the USDZ file, or `nil` if the URL components cannot be resolved or the caches directory cannot be accessed.
    var usdzFileCacheURL: URL? {
        guard
            let cacheDirURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }

        // Remove query parameters and create a unique filename using the lastPathComponent
        let sanitizedFileName = self.deletingPathExtension().lastPathComponent
        let fileName = "\(sanitizedFileName)_cached.usdz"
        
        return cacheDirURL.appendingPathComponent(fileName)
    }
}
