import SwiftUI

//class ExpensesViewModel: ObservableObject {
@Observable
class ExpensesViewModel {
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

//extension ExpensesViewModel {
//    static var mock: ExpensesViewModel {
//        let exp = ExpensesViewModel()
//        exp.items = [
//            ExpenseItem(name: "Restaurant", type: .personal, amount: 24.3),
//            ExpenseItem(name: "Transport", type: .business, amount: 4.33),
//            ExpenseItem(name: "Hotel", type: .business, amount: 400)
//        ]
//        return exp
//    }
//}
