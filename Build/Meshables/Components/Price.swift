//
//  Price.swift
//  Meshables
//
//  Created by Aum Chauhan on 19/08/24.
//

import SwiftUI

/// Represents a price view displays a formatted currency amount or a predefined string with currency code.
struct Price: View {
    
    // MARK: - PROPERTIES
    
    @Binding var amount: Double
    @State private var amountString: String?
    @State private var currencyCode: String?
    
    // MARK: - INITALIZER

    init(_ amount: Binding<Double>, currencyCode: String? = nil) {
        self._amount = amount
        self.currencyCode = currencyCode
        self.amountString = nil
    }
    
    init(_ amount: String) {
        self.amountString = amount
        self._amount = .constant(0)
        self.currencyCode = nil
    }
    
    // MARK: - VIEW BODY
    
    var body: some View {
        if let amountString {
            Text("$\(amountString)")
        } else {
            Text(amount, format: .currency(code: currencyCode ?? "USD"))
        }
    }
}
