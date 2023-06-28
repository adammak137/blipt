import SwiftUI

struct FinalizeDebtScreenView: View {
  
  typealias OnFinalizeComplete = ([Debt]) -> Void

  @State var isClosed: Bool = false
  @ObservedObject var viewModel: FinalizeDebtScreenViewModel
  let onFinalizeComplete: OnFinalizeComplete
  
  @ViewBuilder
  var header: some View {
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
  
  var groupedList: some View {
    List(viewModel.debts, id: \.person.id) { debt in
      DebtItemView(debt: debt)
    }
    .listStyle(GroupedListStyle())
  }
  
  var body: some View {
    NavigationView {
      VStack {
        Group {
          if !isClosed {
            header
          }
          Button("Save") {
            onFinalizeComplete(viewModel.debts)
          }
          Button(isClosed ? "Open" : "Close") {
            isClosed.toggle()
            hideKeyboard()
            viewModel.debts.forEach { debt in
              let view = VStack {
                DebtItemView(debt: debt)
                  .padding(18)
                Spacer()
                  .frame(minHeight: 12)
              }.frame(minWidth: 400)
              let image = view.snapshot()
              UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
          }
        }
        
        groupedList
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
    FinalizeDebtScreenView(viewModel: .init(split: split)) { _ in }
  }
}
