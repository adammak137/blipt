import SwiftUI

struct DebtListView: View {
  
  @ObservedObject var viewModel: DebtViewModel
  
  var body: some View {
    NavigationView {
      VStack {
        Group {
          HStack {
            Text("Subtotal")
              .font(.headline)
            Spacer()
            Text("\(viewModel.allSubtotal.description)")
              .font(.headline)
          }.padding()
          
          HStack {
            Text("Total Tip Amount:")
              .font(.headline)
            TextField("$0.00", text: $viewModel.totalTipAmount)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .keyboardType(.decimalPad)
          }
          .padding()
          
          HStack {
            Text("Total Tax Amount:")
              .font(.headline)
            TextField("$0.00", text: $viewModel.totalTaxAmount)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .keyboardType(.decimalPad)
          }
          .padding()
          
          HStack {
            Text("Grand Total")
              .font(.headline)
            Spacer()
            Text("\(viewModel.grandTotal.description)")
              .font(.headline)
          }.padding()
        }
        
        List(viewModel.debts, id: \.person.id) { debt in
          DebtItemView(debt: debt)
        }
        .listStyle(GroupedListStyle())
      }
      .navigationTitle("Split Receipt")
    }.scrollDismissesKeyboard(.interactively)
  }
}

struct FinalizedSplitView_Previews: PreviewProvider {
  static var previews: some View {
    let split: [Person: [Item]] = [
      .generate(): .stub(),
      .generate(): .stub(),
      .generate(): .stub(),
      .generate(): .stub(),
    ]
    DebtListView(viewModel: .init(split: split))
  }
}