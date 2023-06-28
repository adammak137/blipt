import SwiftUI

struct ReceiptSplitterScreenView : View {
  
  typealias OnSplitComplete = ([Person: [Item]]) -> ()
  @ObservedObject var viewModel: ReceiptSplitterViewModel
  let onSplitComplete: OnSplitComplete
  
  @ViewBuilder
  var listOfPeopleView: some View {
    ScrollView {
      ForEach(
        viewModel.items.sorted(by: { $0.key.name < $1.key.name }),
        id: \.key,
        content: buildNavigationCard
      )
    }
  }
  
  @ViewBuilder
  var activeActionRequiredView: some View {
    if !viewModel.receipt.isEmpty {
      NameInputView { name in
        viewModel.add(person: .init(name: name))
      }
      ReceiptView(
        title: "Remaining Items",
        items: viewModel.receipt,
        onItemDeleteSwipe: { item in
          viewModel.remove(item: item)
        }
      )
    } else {
      Button("Next") {
        onSplitComplete(viewModel.items)
      }
    }
  }
  
  var body: some View {
    VStack {
      listOfPeopleView
      Divider()
      activeActionRequiredView
    }
  }
  
  func buildNavigationCard(person: Person, items: [Item]) -> some View {
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

struct SplitBillScreenView_Previews: PreviewProvider {
  static var previews: some View {
    ReceiptSplitterScreenView(viewModel: .stub) { _ in
    }
    ReceiptSplitterScreenView(viewModel: .init(people: [Person(name: "Preview")], items: []))  { _ in
    }
  }
}
