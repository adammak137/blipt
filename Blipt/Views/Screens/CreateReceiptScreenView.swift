import SwiftUI
import NumberTextField

struct CreateReceiptScreenView: View {
  @State private var items = [ReceiptItem]()
  
  @State private var uniqueItemCount = 0
  
  var body: some View {
    NavigationView {
      VStack {
        ReceiptView(title: "Create Receipt", items: items) { item in
          items.removeAll(where: { $0.id == item.id })
        }
        AddItemForm(onAddTap: onAddFormSubmit)
        
        NavigationLink {
          SplitBillScreenView(viewModel: .init(people: [], receipt: items))
        } label: {
          Text("Done")
        }
        
        
      }
    }
  }
  
  func onAddFormSubmit(name: String?, cost: Double, quantity: Int) {
    uniqueItemCount += 1
    items += (1...quantity).map { itemNumber in
      ReceiptItem(
        name: name ?? "Item #\(uniqueItemCount) (\(itemNumber) of \(quantity))",
        cost: cost
      )
    }
  }
  
}

struct CreateReceiptScreenView_Previews: PreviewProvider {
  static var previews: some View {
    CreateReceiptScreenView()
  }
}


//import SwiftUI
//import NumberTextField
//
//struct CreateReceiptScreenView: View {
//  @State private var receiptItems = [ReceiptItem]()
//  @State private var itemName = ""
//  @State private var itemCost: Double = 0.0
//  @State private var itemQuantity = 1
//
//  var itemQuantityValue: Int {
//    receiptItems.filter({ $0.name.contains("Item #\(itemCount)") }).count + 1
//  }
//
//  var itemCount: Int {
//    receiptItems.count + 1
//  }
//
//  var body: some View {
//    NavigationView {
//      VStack {
//        List(receiptItems) { item in
//          HStack {
//            Text(item.name)
//            Spacer()
//            Text("\(item.cost)")
//          }
//        }
//        Form {
//          Section(header: Text("Add Item")) {
//            TextField("Item Name (Optional)", text: $itemName)
//              .font(.title3)
//              .foregroundColor(.primary)
//              .padding(.vertical, 8)
//            TextField("Cost", value: $itemCost, formatter: NumberFormatter.currency)
//              .keyboardType(.decimalPad)
//              .font(.title3)
//              .foregroundColor(.primary)
//              .padding(.vertical, 8)
//            Picker("Quantity", selection: $itemQuantity) {
//              ForEach((1...15).reversed(), id: \.self) {
//                Text("\($0)")
//              }
//            }
//            .padding(.vertical, 8)
//          }
//          Button(action: {
//            let itemName = self.itemName.isEmpty ? "Item #\(itemCount) - (\(itemQuantityValue) of \(itemQuantity))" : self.itemName
//            let cost = itemCost
//            guard cost > 0, itemQuantity > 0 else {
//              return
//            }
//            (1...itemQuantity).forEach { index in
//              let name = "\(itemName.replacingOccurrences(of: "\(itemQuantityValue) of \(itemQuantity)", with: "\(index) of \(itemQuantity)"))"
//              receiptItems.append(
//                ReceiptItem(
//                  name: name,
//                  cost: cost
//                )
//              )
//            }
//
//            self.itemName = ""
//            self.itemCost = 0.0
//            self.itemQuantity = 1
//          }) {
//            Text("Add Item")
//              .font(.headline)
//              .foregroundColor(.white)
//              .padding(.vertical, 10)
//              .frame(maxWidth: .infinity)
//              .background(Color.blue)
//              .cornerRadius(10)
//          }
//        }
//        .padding(.horizontal)
//        .navigationBarTitle("Add Receipt Item", displayMode: .inline)
//      }
//    }
//  }
//
//  func onAddTap() {
//
//  }
//}
//
//
//
//
//struct CreateReceiptScreenView_Previews: PreviewProvider {
//  static var previews: some View {
//    CreateReceiptScreenView()
//  }
//}
