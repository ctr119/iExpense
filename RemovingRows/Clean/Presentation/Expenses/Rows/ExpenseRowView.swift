//
//  ExpenseRowView.swift
//  RemovingRows
//
//  Created by Víctor Barrios Sánchez on 26/12/23.
//

import SwiftUI

struct ExpenseRowView: View {
    struct Display {
        let name: String
        let type: String
        let amount: Double
        let emoji: String
        let foregroundColor: Color
        let currencyCode: String
    }
    
    let display: Display
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(display.name)
                    .font(.body)
                
                Text(display.type)
                    .font(.caption.italic())
            }
            
            Spacer()
            
            Text(display.emoji)
            
            Text(display.amount, format: .currency(code: display.currencyCode))
                .foregroundStyle(display.foregroundColor)
                .bold(display.foregroundColor == .red)
        }
        .padding()
    }
}

#Preview {
    ExpenseRowView(display: .init(
        name: "Cost",
        type: "Any type",
        amount: 159,
        emoji: "🔥",
        foregroundColor: .red,
        currencyCode: "EUR")
    )
}
