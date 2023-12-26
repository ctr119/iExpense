import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var isAddExpenseScreenPresented = false
    
    private let deviceRepository = DeviceRepository()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                /// Here’s our first quirk:
                ///     The onDelete() modifier only exists on ForEach,
                ///     so if we want users to delete items from a list
                ///     we must put the items inside a ForEach.
                
                List {
                    ForEach(expenses.items) {
                        expenseRow($0)
                    }
                    .onDelete { indexSet in
                        expenses.items.remove(atOffsets: indexSet)
                    }
                }
                .navigationTitle("iExpense")
                .toolbar {
                    Button("Add Expense", systemImage: "plus") {
                        isAddExpenseScreenPresented = true
                    }
                }
            }
        }
        .sheet(isPresented: $isAddExpenseScreenPresented, content: {
            AddView(expenses: expenses)
                .environmentObject(deviceRepository)
        })
    }
    
    private func expenseRow(_ data: ExpenseItem) -> some View {
        let display = display(for: data.amount)
        
        return HStack {
            VStack(alignment: .leading) {
                Text("\(data.name)")
                    .font(.body)
                
                Text("\(data.type.rawValue)")
                    .font(.caption.italic())
            }
            
            Spacer()
            
            Text(display.emoji)
            
            Text(data.amount, format: .currency(code: deviceRepository.getCurrencyCode()))
                .foregroundStyle(display.color)
                .bold(display.color == .red)
        }
    }
    
    private func display(for amount: Double) -> (emoji: String, color: Color) {
        if amount <= 10 {
            return ("☑️", .green)
        }
        
        if amount <= 100 {
            return ("💸", .primary)
        }
        
        return ("🔥", .red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
