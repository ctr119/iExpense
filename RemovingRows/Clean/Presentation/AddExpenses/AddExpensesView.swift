import SwiftUI

struct AddExpensesView: View {
    
    /// @Environment(\.presentationMode) var presentationMode
    /// ...
    /// presentationMode.wrappedValue.dismiss()
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var deviceRepository: DeviceRepository
    
    @State private var name = ""
    @State private var kind: ExpenseItem.Kind = .personal
    @State private var amount: Double? = nil
    
    @State private var isAlertErrorVisible = false
    @State private var errorMessage = ""
    
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
            .toolbar {
                Button("Save") {
                    guard !name.isEmpty else {
                        showError(message: "You have to specify a name")
                        return
                    }
                    guard let amount, amount > 0 else {
                        showError(message: "The amount has to be greater than Zero")
                        return
                    }
                    
                    let newExpense = ExpenseItem(name: name, type: kind, amount: amount)
                    sharedViewModel.add(expenses: [newExpense])
                    dismiss()
                }
            }
            .alert("Oops! Something's wrong", isPresented: $isAlertErrorVisible) {
                Button("Ok") {}
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    private func showError(message: String) {
        errorMessage = message
        isAlertErrorVisible = true
    }
}

#Preview {
    AddExpensesView(
        sharedViewModel: ExpensesViewModel(
            loadExpensesUseCase: .mock,
            saveExpensesUseCase: .mock
        )
    )
    .environmentObject(DeviceRepository())
}
