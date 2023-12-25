import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var isAddExpenseScreenPresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                /// Here’s our first quirk:
                ///     The onDelete() modifier only exists on ForEach,
                ///     so if we want users to delete items from a list
                ///     we must put the items inside a ForEach.
                
                List {
                    ForEach(expenses.items) {
                        Text("Expense \($0.name)")
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
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
