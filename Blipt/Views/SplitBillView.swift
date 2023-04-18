import SwiftUI

struct SplitBillView: View {
  @ObservedObject var viewModel: SplitBillViewModel
  
  var body: some View {
    NavigationStack {
      VStack {
        ScrollView {
          ForEach(viewModel.items.sorted(by: { $0.key.name < $1.key.name }), id: \.key) { person, items in
            NavigationLink {
              ReceiptView(
                title: "\(person.name)'s Items",
                items: items,
                onItemDeleteSwipe: {
                  viewModel.remove(item: $0, from: person)
                }
              )
            } label: {
              PersonCardView(
                person: person,
                items: items,
                onItemDropped: { viewModel.add(item: $0, to: person) },
                onItemRemovedFromPerson: { viewModel.remove(item: $0, from: person) }
              )
              .padding(.horizontal)
            }
            .simultaneousGesture(TapGesture())
          }
        }
        Divider()
        if !viewModel.receipt.isEmpty {
          ReceiptView(
            title: "Remaining Items",
            items: viewModel.receipt,
            onItemDeleteSwipe: { item in
              viewModel.remove(item: item)
            }
          )
        } else {
          Button("Continue") {
            // TODO
          }
        }
      }
    }
  }
}

struct SplitBillView_Previews: PreviewProvider {
  static var previews: some View {
    SplitBillView(viewModel: .stub)
  }
}
