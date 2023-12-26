import SwiftUI

//class ExpensesViewModel: ObservableObject {
@Observable
class ExpensesViewModel {
    var expenses: [ExpenseItem] = []
    
    private let loadExpensesUseCase: LoadExpensesUseCase
    
    init(loadExpensesUseCase: LoadExpensesUseCase = .init()) {
        self.loadExpensesUseCase = loadExpensesUseCase
    }
    
    func onAppear() {
        expenses = loadExpensesUseCase()
    }
    
    func submitChanges() {
        // TODO: Call the right Use Case for storing the data
    }
    
//    var items = [ExpenseItem]() {
//        didSet {
//            if let data = try? JSONEncoder().encode(items) {
//                UserDefaults.standard.setValue(data, forKey: "Items")
//            }
//        }
//    }
}
