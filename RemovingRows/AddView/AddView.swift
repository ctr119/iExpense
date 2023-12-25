import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var kind: ExpenseItem.Kind = .personal
    @State private var amount = 0.0

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

                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
        }
    }
}

#Preview {
    AddView()
}