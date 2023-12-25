import SwiftUI

//class Expenses: ObservableObject {
@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let data = try? JSONEncoder().encode(items) {
                UserDefaults.standard.setValue(data, forKey: "Items")
            }
        }
    }
    
    init() {
        if let itemsData = UserDefaults.standard.data(forKey: "Items"),
           let items = try? JSONDecoder().decode([ExpenseItem].self, from: itemsData) {
            self.items = items
            return
        }
        
        self.items = []
    }
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
