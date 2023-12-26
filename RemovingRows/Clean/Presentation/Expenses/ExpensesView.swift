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
                    personalSection
                
                    businessSection
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
    
    @ViewBuilder
    private var personalSection: some View {
        Section {
            ForEach(viewModel.personalExpenses) {
                ExpenseRowView(
                    display: $0.toExpenseRowDisplay(
                        currencyCode: viewModel.currencyCode
                    )
                )
            }
            .onDelete { indexSet in
                viewModel.removeExpenses(from: indexSet, ofKind: .personal)
            }
        } header: {
            Text("Personal expenses")
        }
    }
    
    @ViewBuilder
    private var businessSection: some View {
        Section {
            ForEach(viewModel.businessExpenses) {
                ExpenseRowView(
                    display: $0.toExpenseRowDisplay(
                        currencyCode: viewModel.currencyCode
                    )
                )
            }
            .onDelete { indexSet in
                viewModel.removeExpenses(from: indexSet, ofKind: .business)
            }
        } header: {
            Text("Business expenses")
        }
    }
}

#Preview {
    ExpensesView(viewModel: .init(loadExpensesUseCase: .mock))
}
