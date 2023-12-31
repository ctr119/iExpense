//
//  SaveExpensesUseCase.swift
//  RemovingRows
//
//  Created by Víctor Barrios Sánchez on 26/12/23.
//

import Foundation

class SaveExpensesUseCase {
    private let repository: ExpensesRepository
    
    init(repository: ExpensesRepository = .init()) {
        self.repository = repository
    }
    
    func callAsFunction(_ expenses: [ExpenseItem]) {
        repository.saveExpenses(expenses)
    }
}

#if DEBUG
extension SaveExpensesUseCase {
    static var mock: SaveExpensesUseCase {
        SaveExpensesUseCaseMock()
    }
}

class SaveExpensesUseCaseMock: SaveExpensesUseCase {
    override func callAsFunction(_ expenses: [ExpenseItem]) {
        // Empty
    }
}
#endif
