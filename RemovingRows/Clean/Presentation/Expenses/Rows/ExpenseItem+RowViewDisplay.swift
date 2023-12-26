//
//  ExpenseItem+RowViewDisplay.swift
//  RemovingRows
//
//  Created by Víctor Barrios Sánchez on 26/12/23.
//

import SwiftUI

extension ExpenseItem {
    var toExpenseRowDisplay: ExpenseRowView.Display {
        let display = display(for: self.amount)
        
        
        return .init(
            info: .init(name: self.name,
                        type: self.type.rawValue,
                        amount: self.amount),
            formatting: .init(emoji: display.emoji,
                              foregroundColor: display.color,
                              currencyCode: Locale.current.currency?.identifier ?? "EUR")
        )
    }
    
    private func display(for amount: Double) -> (emoji: String, color: Color) {
        if amount <= 10 {
            return ("☑️", .green)
        }
        
        if amount <= 100 {
            return ("💸", .primary)
        }
        
        return ("🔥", .red)
    }
}
