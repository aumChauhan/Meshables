//
//  Model3DViewModel.swift
//  Meshables
//
//  Created by Aum Chauhan on 09/09/24.
//

import SwiftUI
import RealityKit

/// ViewModel for managing the state and operations related to a 3D model loaded from a USDZ file.
@MainActor
class Model3DViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    
    var onItemDeleted: (() -> Void)? = nil
    
    @Published var usdzFileURL: URL?
    @Published var entity: ModelEntity?
    @Published var isLoading: Bool = false
    
    // MARK: - SERVICES
    
    /// Asynchronously fetches the USDZ file from a remote URL and creates a `ModelEntity` from it.
    func fetchUSDZFileURL(from urlKey: String) async {
        isLoading = true
        guard let usdzURL = URL(string: urlKey), let cacheURL = usdzURL.usdzFileCacheURL else { return }
        
        do {
            let fetchedURL = try await USDZFileService.shared.fetchUSDZFile(usdzURL: usdzURL, cacheURL: cacheURL)
            
            let entity = try await ModelEntity(contentsOf: fetchedURL)
            entity.name = usdzURL.absoluteString
            entity.generateCollisionShapes(recursive: true)
            entity.components.set(InputTargetComponent())
            
            self.usdzFileURL = fetchedURL
            self.entity = entity
            
            isLoading = false
        } catch {
            isLoading = false
            self.usdzFileURL = nil
            self.entity = nil
        }
    }
}
