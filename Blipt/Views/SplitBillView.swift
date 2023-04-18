import SwiftUI

struct SplitBillView: View {
  @ObservedObject var viewModel: SplitBillViewModel
  
  var body: some View {
    NavigationStack {
      VStack {
        ScrollView {
          ForEach(
            viewModel.items.sorted(by: { $0.key.name < $1.key.name }),
            id: \.key,
            content: buildNavigationCard
          )
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
  
  func buildNavigationCard(person: Person, items: [ReceiptItem]) -> some View {
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
        onItemDroppedIn: { viewModel.add(item: $0, to: person) }
      )
      .padding(.horizontal)
    }
  }
}

struct SplitBillView_Previews: PreviewProvider {
  static var previews: some View {
    SplitBillView(viewModel: .stub)
    SplitBillView(viewModel: .init(people: [Person(name: "Preview")], receipt: []))
  }
}
