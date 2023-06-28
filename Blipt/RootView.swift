import SwiftUI


enum Route: Hashable {
  case build(items: [Item])
  case split(people: [Person], items: [Item])
  case finalize(split: [Person: [Item]])
  case view(debts: [Debt])
  
  // Implementing Equatable conformance
  static func ==(lhs: Route, rhs: Route) -> Bool {
    switch (lhs, rhs) {
    case let (.build(items: lhsItems), .build(items: rhsItems)):
      return lhsItems == rhsItems
    case let (.split(people: lhsPeople, items: lhsItems), .split(people: rhsPeople, items: rhsItems)):
      return lhsPeople == rhsPeople && lhsItems == rhsItems
    case let (.finalize(split: lhsSplit), .finalize(split: rhsSplit)):
      return lhsSplit == rhsSplit
    case let (.view(debts: lhsDebts), .view(debts: rhsDebts)):
      return lhsDebts == rhsDebts
    default:
      return false
    }
  }
  
  // Implementing Hashable conformance
  func hash(into hasher: inout Hasher) {
    switch self {
    case let .build(items):
      hasher.combine(0)
      hasher.combine(items)
    case let .split(people, items):
      hasher.combine(1)
      hasher.combine(people)
      hasher.combine(items)
    case let .finalize(split):
      hasher.combine(2)
      hasher.combine(split)
    case let .view(debts):
      hasher.combine(3)
      hasher.combine(debts)
    }
  }
}

struct RootView: View {
  @State
  var path = NavigationPath() //: [Route] = []
  
  var body: some View {
    NavigationStack(path: $path) {
      List {
        NavigationLink("Start", value: Route.build(items: []))
        NavigationLink("Test", value: "TEST")
      }
      .navigationDestination(for: Route.self) { route in
        view(for: route)
      }
      .navigationDestination(for: String.self) { str in
        Text(str)
      }
    }
  }
  
  @ViewBuilder
  func view(for route: Route) -> some View {
    switch route {
    case .build(let buildItems):
      ReceiptBuilderScreenView(items: buildItems) { items in
        path.append(Route.split(people: [], items: items))
      }
    case .split(let people, let splitItems):
      ReceiptSplitterScreenView(viewModel: .init(people: people, items: splitItems)) { split in
        path.append(Route.finalize(split: split))
      }
    case .finalize(let split):
      FinalizeDebtScreenView(viewModel: .init(split: split)) { debts in
        path.append(Route.view(debts: debts))
      }
    case .view(let debts):
      Text(debts.description)
    }
  }
}
