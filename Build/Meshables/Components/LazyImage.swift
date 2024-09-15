//
//  LazyImage.swift
//  Meshables
//
//  Created by Aum Chauhan on 08/09/24.
//

import SwiftUI
import SDWebImageSwiftUI

/// A view that asynchronously loads and displays an image from a URL, with a progress indicator during loading.
struct LazyImage: View {

    // MARK: - PROPERTIES
    
    let url: String
    
    // MARK: - INITIALIZER
    
    init(_ url: String) {
        self.url = url
    }

    // MARK: - VIEW BODY
    
    var body: some View {
        WebImage(url: URL(string: url))
            .resizable()
            .indicator { _, _ in
                ProgressBar()
            }
            .scaledToFill()
    }
}
