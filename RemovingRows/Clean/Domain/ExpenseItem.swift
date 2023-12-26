import Foundation

struct ExpenseItem: Identifiable, Codable {
    enum Kind: String, CaseIterable, Codable {
        case business
        case personal
    }
    
    var id = UUID()
    let name: String
    let type: Kind
    let amount: Double
}
