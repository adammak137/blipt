import SwiftUI

struct AddItemForm: View {
  
  typealias OnAddTap = (String?, Double, Int) -> ()
  
  @State private var itemName = ""
  @State private var itemCost: Double = 1.0
  @State private var itemQuantity = 1
  
  let onAddTap: OnAddTap?
  
  var body: some View {
    Form {
      Section(header: Text("Add Item")) {
        TextField("Item Name (Optional)", text: $itemName)
          .font(.title3)
          .foregroundColor(.primary)
          .padding(.vertical, 8)
        TextField("Cost", value: $itemCost, formatter: NumberFormatter.currency)
          .keyboardType(.decimalPad)
          .font(.title3)
          .foregroundColor(.primary)
          .padding(.vertical, 8)
        Picker("Quantity", selection: $itemQuantity) {
          ForEach((1...15).reversed(), id: \.self) {
            Text("\($0)")
          }
        }
        .padding(.vertical, 8)
      }
      Button(action: onAddButtonTap) {
        Text("Add Item")
          .font(.headline)
          .foregroundColor(.white)
          .padding(.vertical, 10)
          .frame(maxWidth: .infinity)
          .background(Color.blue)
          .cornerRadius(10)
      }
    }
    .padding(.horizontal)
  }
  
  private func onAddButtonTap() {
    guard itemCost > 0, itemQuantity > 0 else {
      return
    }
    
    let shouldNameBeNil = itemName.isEmpty || itemName.isBlank
    let name = shouldNameBeNil ? nil : itemName
    
    onAddTap?(name, itemCost, itemQuantity)
    
    self.itemName = ""
    self.itemCost = 1.0
    self.itemQuantity = 1
  }
}

struct AddItemForm_Previews: PreviewProvider {
  static var previews: some View {
    AddItemForm(onAddTap: nil)
  }
}
