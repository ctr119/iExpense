import SwiftUI

//class ExpensesViewModel: ObservableObject {
@Observable
class ExpensesViewModel {
    var businessExpenses: [ExpenseItem] {
        expenses.filter { $0.type == .business }
    }
    var personalExpenses: [ExpenseItem] {
        expenses.filter { $0.type == .personal }
    }
    var currencyCode: String {
        Locale.current.currency?.identifier ?? "EUR"
    }
    
    private let loadExpensesUseCase: LoadExpensesUseCase
    private let saveExpensesUseCase: SaveExpensesUseCase
    
    private var expenses: [ExpenseItem] = []
    
    init(loadExpensesUseCase: LoadExpensesUseCase = .init(),
         saveExpensesUseCase: SaveExpensesUseCase = .init()) {
        self.loadExpensesUseCase = loadExpensesUseCase
        self.saveExpensesUseCase = saveExpensesUseCase
    }
    
    func onAppear() {
        expenses = loadExpensesUseCase()
    }
    
    func add(expenses: [ExpenseItem]) {
        self.expenses.append(contentsOf: expenses)
        
        saveExpensesUseCase(self.expenses)
    }
    
    func removeExpenses(from indexSet: IndexSet, ofKind kind: ExpenseItem.Kind) {
        let filteredExpenses = expenses.filter { $0.type == kind }
        let expensesToRemove: [ExpenseItem] = indexSet.compactMap {
            guard $0 < filteredExpenses.count else { return nil }
            return filteredExpenses[$0]
        }
        
        guard !expensesToRemove.isEmpty else { return }
        remove(expensesToRemove)
    }
    
    private func remove(_ expenses: [ExpenseItem]) {
        self.expenses.removeAll { item in
            expenses.contains {
                $0.id == item.id
            }
        }
        
        saveExpensesUseCase(self.expenses)
    }
}
