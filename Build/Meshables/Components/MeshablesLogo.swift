//
//  MeshablesLogo.swift
//  Meshables
//
//  Created by Aum Chauhan on 19/08/24.
//

import SwiftUI

/// Displays the Meshables logo alongside the app’s name in a horizontally aligned stack.
struct MeshablesLogo: View {
    var body: some View {
        HStack(spacing: UIConstants.standardHStackSpacing) {
            Image("MeshablesLogo")
                .resizable()
                .scaledToFill()
                .frame(width: 20, height: 20)
            
            Text("Meshables")
                .font(.title)
                .fontDesign(.serif)
        }
    }
}
