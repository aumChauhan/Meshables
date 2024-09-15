//
//  Asset.swift
//  Meshables
//
//  Created by Aum Chauhan on 19/08/24.
//

import Firebase

/// Represents a 3D asset with various properties including metadata, pricing, and visual details.
struct Asset: Codable, Hashable {
    let userId: String?
    let title: String
    let thumbnail: String
    let description: String
    let is3d: Bool
    let price: String
    let discount: String?
    let category: String
    let type: String
    let tags: [String]
    let date: Timestamp
    
    // MARK: - MODELS
    
    let model: String?
    let usdzURL: String?
    let resolution: String?
    let physicalSize: String?
    let lods: String?
    let vertices: String?
    let textures: Bool?
    let materials: Bool?
    let uvMapping: Bool?
    let rigged: Bool?
    let animated: Bool?
    let vrArLowPoly: Bool?
    
    // MARK: - SCRIPT
    
    let script: String?
    let scriptName: String?
    let scriptSize: Int?
    // let maps: Maps?
    
    // MARK: - PRINTABLES
    
    let volume: String?
    let surfaceArea: String?
    let layerHeight: String?
    let infillPercentage: String?
    let printTimeEstimate: String?
    let material: String?
    let nozzleSize: String?
    let watertight: Bool?
    let manifold: Bool?
    let supportsRequired: Bool?
}

struct Maps: Codable, Hashable {
    var ambientOcclusion: String?
    var baseColor: String?
    var bump: String?
    var displacement: String?
    var idmap: String?
    var metallic: String?
    var normal: String?
    var roughness: String?
}
