import SwiftUI

struct SplitBillScreenView<Destination>: View where Destination : View {
  
  typealias SplitBillContentDestination = ([Person: [ReceiptItem]]) -> Destination
  let destination: SplitBillContentDestination
  
  @ObservedObject var viewModel: SplitBillViewModel
  
  init(viewModel: SplitBillViewModel,
       @ViewBuilder destination: @escaping SplitBillContentDestination) {
    self.viewModel = viewModel
    self.destination = destination
  }
  
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
      PersonInputView { name in
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
      NavigationLink {
        destination(viewModel.items)
      } label: {
        Text("Next")
      }
    }
  }
  
  var body: some View {
    NavigationStack {
      VStack {
        listOfPeopleView
        Divider()
        activeActionRequiredView
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

struct SplitBillScreenView_Previews: PreviewProvider {
  static var previews: some View {
    SplitBillScreenView(viewModel: .stub) {
      Text("Preview of next screen with content: \(String(describing: $0))")
    }
    SplitBillScreenView(viewModel: .init(people: [Person(name: "Preview")], receipt: []))  {
      Text("Preview of next screen with content: \(String(describing: $0))")
    }
  }
}
