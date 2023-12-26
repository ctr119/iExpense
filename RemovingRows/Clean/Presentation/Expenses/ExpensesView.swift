import SwiftUI

struct ExpensesView: View {
    @State var viewModel = ExpensesViewModel()
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
                    ForEach(viewModel.expenses) {
                        ExpenseRowView(display: $0.toExpenseRowDisplay)
                    }
                    .onDelete { indexSet in
                        viewModel.expenses.remove(atOffsets: indexSet)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    isAddExpenseScreenPresented = true
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .sheet(isPresented: $isAddExpenseScreenPresented, content: {
            AddExpensesView(sharedViewModel: viewModel)
                .environmentObject(deviceRepository)
        })
    }
}

#Preview {
    ExpensesView(viewModel: .init(loadExpensesUseCase: .mock))
}
