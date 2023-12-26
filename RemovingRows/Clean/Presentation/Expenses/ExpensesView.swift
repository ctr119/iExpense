import SwiftUI

struct ExpensesView: View {
    @State var viewModel = ExpensesViewModel()
    @State private var isAddExpenseScreenPresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                /// Here’s our first quirk:
                ///     The onDelete() modifier only exists on ForEach,
                ///     so if we want users to delete items from a list
                ///     we must put the items inside a ForEach.
                
                List {
                    ForEach(viewModel.expenses) {
                        ExpenseRowView(
                            display: $0.toExpenseRowDisplay(
                                currencyCode: viewModel.currencyCode
                            )
                        )
                    }
                    .onDelete { indexSet in
                        viewModel.removeExpense(at: indexSet)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expenses", systemImage: "plus") {
                    isAddExpenseScreenPresented = true
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .sheet(isPresented: $isAddExpenseScreenPresented, content: {
            AddExpensesView(sharedViewModel: viewModel)
        })
    }
}

#Preview {
    ExpensesView(viewModel: .init(loadExpensesUseCase: .mock))
}
