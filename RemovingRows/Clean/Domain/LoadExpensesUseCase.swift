import Foundation

class LoadExpensesUseCase {
    private let expensesRepository: ExpensesRepository
    
    init(expensesRepository: ExpensesRepository = .init()) {
        self.expensesRepository = expensesRepository
    }
    
    func callAsFunction() -> [ExpenseItem] {
        expensesRepository.getExpenses()
    }
}
