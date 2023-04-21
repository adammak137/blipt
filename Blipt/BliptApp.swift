import SwiftUI

@main
struct BliptApp: App {
  var body: some Scene {
    WindowGroup {
      ReceiptBuilderScreenView(items: []) { items in
        ReceiptSplitterScreenView(viewModel: .init(people: [], receipt: items)) { split in
          DebtListView(viewModel: .init(split: split))
        }
      }
    }
  }
}
