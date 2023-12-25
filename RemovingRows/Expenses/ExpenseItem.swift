import Foundation

struct ExpenseItem: Identifiable {
    enum Kind: String, CaseIterable {
        case business
        case personal
    }
    
    let id = UUID()
    let name: String
    let type: Kind
    let amount: Double
}