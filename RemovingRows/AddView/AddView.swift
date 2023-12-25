import SwiftUI

struct AddView: View {
    
    /// @Environment(\.presentationMode) var presentationMode
    /// ...
    /// presentationMode.wrappedValue.dismiss()
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var deviceRepository: DeviceRepository
    
    @State private var name = ""
    @State private var kind: ExpenseItem.Kind = .personal
    @State private var amount = 0.0
    
    var expenses: Expenses

    let types = ["Business", "Personal"]

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
            .navigationTitle("Add new expense")
        }
        .toolbar {
            Button("Save") {
                let newExpense = ExpenseItem(name: name, type: kind, amount: amount)
                expenses.items.append(newExpense)
                dismiss()
            }
        }
    }
}

#Preview {
    AddView(expenses: .mock)
}
