import Foundation

class ExpensesDataSource {
    private enum Keys: String {
        case expenses = "items"
    }
    
    private let store: UserDefaults
    
    init(store: UserDefaults = .standard) {
        self.store = store
    }
    
    func getItems() -> Data? {
        store.data(forKey: Keys.expenses.rawValue)
    }
    
    func saveItems(_ data: Data) {
        store.setValue(data, forKey: Keys.expenses.rawValue)
    }
}
