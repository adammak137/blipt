import SwiftUI

struct ReceiptView: View {
  
  typealias OnItemDeleteSwipe = (Item) -> ()
  
  let title: String
  let items: [Item]
  let onItemDeleteSwipe: OnItemDeleteSwipe?
  
  var total: Double { items.map(\.cost).reduce(0, +) }
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(title)
        .bold(true)
        .font(.title)
        .padding(.bottom)
      Divider()
      List {
        ForEach(items) { item in
          ReceiptItemView(item: item)
            .draggable(item)
        }
        .onDelete(perform: deleteItems)
      }
      
      .listStyle(.plain)
      Divider()
      HStack {
        Text("Total:")
          .font(.headline)
        Spacer()
        Text("$\(total, specifier: "%.2f")")
      }
      .padding(.top)
    }
    .padding()
  }
  
  func deleteItems(at offsets: IndexSet) {
    // Get the items to be deleted based on the offsets
    let deletedItems = offsets.map { items[$0] }
    
    // Call the onItemDeleteSwipe closure for each deleted item
    deletedItems.forEach { deletedItem in
      onItemDeleteSwipe?(deletedItem)
    }
  }
}




struct ReceiptView_Previews: PreviewProvider {
  static var previews: some View {
    ReceiptView(
      title: "Receipt",
      items: .stub(),
      onItemDeleteSwipe: nil
    )
  }
}


//Text("$\(items.map(\.cost).reduce(0, +), specifier: "%.2f")")
