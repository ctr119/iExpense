import SwiftUI

//class ExpensesViewModel: ObservableObject {
@Observable
class ExpensesViewModel {
    private(set) var expenses: [ExpenseItem] = []
    
    private let loadExpensesUseCase: LoadExpensesUseCase
    private let saveExpensesUseCase: SaveExpensesUseCase
    
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
    
    func removeExpense(at indexSet: IndexSet) {
        expenses.remove(atOffsets: indexSet)
        
        saveExpensesUseCase(expenses)
    }
}
