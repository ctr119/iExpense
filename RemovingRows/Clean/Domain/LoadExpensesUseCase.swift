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

#if DEBUG
extension LoadExpensesUseCase {
    static var mock: LoadExpensesUseCase {
        LoadExpensesUseCaseMock()
    }
}

class LoadExpensesUseCaseMock: LoadExpensesUseCase {
    override func callAsFunction() -> [ExpenseItem] {
        [
            ExpenseItem(name: "Transport", type: .business, amount: 4.33),
            ExpenseItem(name: "Restaurant", type: .personal, amount: 24.3),
            ExpenseItem(name: "Hotel", type: .business, amount: 400)
        ]
    }
}
#endif
