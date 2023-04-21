import SwiftUI

@main
struct BliptApp: App {
  var body: some Scene {
    WindowGroup {
      ReceiptBuilderScreenView(items: []) { items in
        ReceiptSplitterScreenView(viewModel: .init(people: [], receipt: items)) { split in
          DebtListScreenView(viewModel: .init(split: split))
        }
      }
    }
  }
}
