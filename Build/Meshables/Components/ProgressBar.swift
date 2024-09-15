//
//  ProgressBar.swift
//  Meshables
//
//  Created by Aum Chauhan on 03/09/24.
//

import SwiftUI

/// Represents a progress indicator for showing ongoing processes or loading states.
public struct ProgressBar: View {
    
    // MARK: - PROPERTIES
    
    let titleKey: String?
    private let lineWidth: CGFloat = 2
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    @State private var rotationAngle: Double = 0
    
    // MARK: - INITIALIZER
   
    init() {
        self.titleKey = nil
    }
    
    init(titleKey: String) {
        self.titleKey = titleKey
    }
    
    // MARK: - VIEW BODY

    public var body: some View {
        VStack(alignment: .center, spacing: UIConstants.compactVStackSpacing) {
            ProgressArc()
                .stroke(.primary, lineWidth: lineWidth)
                .frame(width: 35, height: 35)
                .rotationEffect(Angle(degrees: rotationAngle))
                .onReceive(timer) { _ in
                    withAnimation {
                        rotationAngle += 40
                    }
                }
            
            if let titleKey {
                Text(titleKey)
                    .primaryTitle()
            }
        }
    }
}

/// A custom shape for the `ProgressBar`.
fileprivate struct ProgressArc: Shape {
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let startAngle: Angle = .degrees(0)
        let endAngle: Angle = .degrees(360 * 0.8) // 80% of the circle
        
        var path = Path()
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        return path
    }
}
