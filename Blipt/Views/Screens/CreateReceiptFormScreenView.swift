//import SwiftUI
//
//struct CreateReceiptFormScreenView: View {
//  @State var items: [ReceiptItem]
//  
//  @State private var uniqueItemCount = 0
//  
//  var body: some View {
//    NavigationView {
//      VStack {
//        ReceiptView(title: "Create Receipt",
//                    items: items,
//                    onItemDeleteSwipe: onReceiptRemove)
//        AddItemForm(onAddTap: onAddFormSubmit)
//        nextScreenButton
//      }
//    }
//  }
//  
//  @ViewBuilder
//  var nextScreenButton: some View {
//    NavigationLink {
//      SplitBillScreenView(viewModel: .init(people: [], receipt: items))
//    } label: {
//      Text("Done")
//    }
//  }
//  
//  func onReceiptRemove(item: ReceiptItem) {
//    items.removeAll(where: { $0.id == item.id })
//  }
//  
//  func onAddFormSubmit(name: String?, cost: Double, quantity: Int) {
//    uniqueItemCount += 1
//    items += (1...quantity).map { itemNumber in
//      ReceiptItem(
//        name: name ?? "Item #\(uniqueItemCount) (\(itemNumber) of \(quantity))",
//        cost: cost
//      )
//    }
//  }
//  
//}
//
//struct CreateReceiptScreenView_Previews: PreviewProvider {
//  static var previews: some View {
//    CreateReceiptFormScreenView(
//      items: .stub()
//    )
//  }
//}
