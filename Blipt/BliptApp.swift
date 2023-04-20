import SwiftUI

@main
struct BliptApp: App {
  var body: some Scene {
    WindowGroup {
      ReceiptBuilderScreenView(items: []) { items in
        SplitBillScreenView(viewModel: .init(people: [], receipt: items)) { split in
          Text(String(describing: split))
        }
      }
    }
  }
}
