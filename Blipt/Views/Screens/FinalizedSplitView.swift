import SwiftUI

struct FinalizedSplitView: View {
  
  @ObservedObject var viewModel: FinalizedSplitBillViewModel
  
  var body: some View {
    NavigationView {
      VStack {
        Group {
          HStack {
            Text("Total Tip Amount:")
            TextField("$0.00", text: $viewModel.totalTipAmount)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .keyboardType(.decimalPad)
          }
          .padding()
          
          HStack {
            Text("Total Tax Amount:")
            TextField("$0.00", text: $viewModel.totalTaxAmount)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .keyboardType(.decimalPad)
          }
          .padding()
        }
        
        List(viewModel.debts, id: \.person.id) { debt in
          DebtView(debt: debt)
        }
        .listStyle(GroupedListStyle())
      }
      .navigationTitle("Split Receipt")
    }.scrollDismissesKeyboard(.interactively)
  }
}

struct FinalizedSplitView_Previews: PreviewProvider {
  static var previews: some View {
    let person1 = Person(name: "Alice")
    let person2 = Person(name: "Bob")
    let split: [Person: [ReceiptItem]] = [
      person1: .stub(),
      person2: .stub()
    ]
    FinalizedSplitView(viewModel: .init(split: split))
  }
}
