import SwiftUI

struct AddExpensesView: View {
    
    /// @Environment(\.presentationMode) var presentationMode
    /// ...
    /// presentationMode.wrappedValue.dismiss()
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var deviceRepository: DeviceRepository
    
    @State private var name = ""
    @State private var kind: ExpenseItem.Kind = .personal
    @State private var amount = 0.0
    
    var sharedViewModel: ExpensesViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Kind", selection: $kind) {
                    ForEach(ExpenseItem.Kind.allCases, id: \.self) {
                        Text($0.rawValue.capitalized)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: deviceRepository.getCurrencyCode()))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add New Expense")
        }
        .toolbar {
            Button("Save") {
                let newExpense = ExpenseItem(name: name, type: kind, amount: amount)
                sharedViewModel.add(expenses: [newExpense])
                dismiss()
            }
        }
    }
}

//#Preview {
//    AddView(expenses: .mock)
//}
