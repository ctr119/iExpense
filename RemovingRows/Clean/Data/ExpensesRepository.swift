import Foundation

class ExpensesRepository {
    private let dataSource: ExpensesDataSource
    
    init(dataSource: ExpensesDataSource = .init()) {
        self.dataSource = dataSource
    }
    
    func getExpenses() -> [ExpenseItem] {
        if let data = dataSource.getItems(),
           let items = try? JSONDecoder().decode([ExpenseItem].self, from: data) {
            return items
        }
        
        return []
    }
    
    func saveExpenses(_ expenses: [ExpenseItem]) {
        if let data = try? JSONEncoder().encode(expenses) {
            dataSource.saveItems(data)
        }
    }
}
