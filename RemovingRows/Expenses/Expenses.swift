import SwiftUI

//class Expenses: ObservableObject {
@Observable
class Expenses {
    var items = [ExpenseItem]()
}

extension Expenses {
    static var mock: Expenses {
        let exp = Expenses()
        exp.items = [
            ExpenseItem(name: "Restaurant", type: .personal, amount: 24.3),
            ExpenseItem(name: "Transport", type: .business, amount: 4.33)
        ]
        return exp
    }
}
