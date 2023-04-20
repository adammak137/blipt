import SwiftUI

struct FinalizedSplitView: View {
  
  @StateObject var viewModel: FinalizedSplitBillViewModel
  
  enum Field {
    case tip, tax
  }
  @FocusState private var focusedField: Field?

  var body: some View {
    NavigationView {
      VStack {
        Group {
          HStack {
            Text("Total Tip Amount:")
            TextField("$0.00", text: $viewModel.totalTipAmount)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .keyboardType(.decimalPad)
              .focused($focusedField, equals: .tip)
          }
          .padding()
          
          HStack {
            Text("Total Tax Amount:")
            TextField("$0.00", text: $viewModel.totalTaxAmount)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .keyboardType(.decimalPad)
              .focused($focusedField, equals: .tax)
          }
          .padding()
        }
        List {
          ForEach(Array(viewModel.split.keys), id: \.id) { person in
            Section(header: Text("\(person.name)'s Items")) {
              ForEach(viewModel.split[person] ?? [], id: \.id) { item in
                HStack {
                  Text(item.name)
                  Spacer()
                  Text("\(item.price.description)")
                }
              }
              VStack(alignment: .leading, spacing: 8) {
                HStack {
                  Text("Subtotal")
                    .font(.headline)
                  Spacer()
                  Text("\(viewModel.subtotalCost(for: person).description)")
                    .font(.headline)
                }
                
                HStack {
                  Text("Tip")
                    .font(.headline)
                  Spacer()
                  Text("\(viewModel.tipAmount(for: person).description)")
                    .font(.headline)
                }
                
                HStack {
                  Text("Tax")
                    .font(.headline)
                  Spacer()
                  Text("\(viewModel.taxAmount(for: person).description)")
                    .font(.headline)
                }
                
                HStack {
                  Text("Total")
                    .font(.headline)
                  Spacer()
                  Text("\(viewModel.grandTotal(for: person).description)")
                    .font(.headline)
                }
              }
            }
          }
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
    
    let items1: [ReceiptItem] = [
      ReceiptItem(name: "Coffee", cost: 3.50),
      ReceiptItem(name: "Bagel", cost: 2.25)
    ]
    
    let items2: [ReceiptItem] = [
      ReceiptItem(name: "Tea", cost: 2.75),
      ReceiptItem(name: "Muffin", cost: 1.75)
    ]
    
    let split: [Person: [ReceiptItem]] = [
      person1: items1,
      person2: items2
    ]
    
    FinalizedSplitView(viewModel: .init(split: split))
  }
}
