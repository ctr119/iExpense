//
//  ExpenseRowView.swift
//  RemovingRows
//
//  Created by Víctor Barrios Sánchez on 26/12/23.
//

import SwiftUI

struct ExpenseRowView: View {
    struct Display {
        struct Info {
            let name: String
            let type: String
            let amount: Double
        }
        
        struct Formatting {
            let emoji: String
            let foregroundColor: Color
            let currencyCode: String
        }
        
        let info: Info
        let formatting: Formatting
    }
    
    let display: Display
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(display.info.name)
                    .font(.body)
                
                Text(display.info.type)
                    .font(.caption.italic())
            }
            
            Spacer()
            
            Text(display.formatting.emoji)
            
            Text(display.info.amount,
                 format: .currency(code: display.formatting.currencyCode))
                .foregroundStyle(display.formatting.foregroundColor)
                .bold(display.formatting.foregroundColor == .red)
        }
    }
}

#Preview {
    ExpenseRowView(display: .init(
        info: .init(name: "Expense",
                    type: "Travel",
                    amount: 159),
        formatting: .init(emoji: "✈️",
                          foregroundColor: .red,
                          currencyCode: "EUR")
    ))
    .padding()
}
