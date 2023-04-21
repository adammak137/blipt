import Foundation

class FinalizedSplitBillViewModel: ObservableObject {
  
  @Published var totalTipAmount: String = "" {
    didSet { updateDebts() }
  }
  
  @Published var totalTaxAmount: String = "" {
    didSet { updateDebts() }
  }
  
  @Published var debts: [Debt] = []
  
  private let split: [Person: [ReceiptItem]]
  
  init(split: [Person: [ReceiptItem]]) {
    self.split = split
    updateDebts()
  }
  
  private func updateDebts() {
    let allSubtotal: Price = split.values.map{ $0.total }.reduce(.zero, { $0 + $1 })
    debts = split.map { person, items in
      Debt(
        person: person,
        items: items,
        tip: calculateAmount(amountStringValue: totalTipAmount, items: items, allSubtotal: allSubtotal),
        tax: calculateAmount(amountStringValue: totalTaxAmount, items: items, allSubtotal: allSubtotal)
      )
    }
  }
  
  private func calculateAmount(amountStringValue: String, items: [ReceiptItem], allSubtotal: Price) -> Price {
    guard let doubleValue = Double(amountStringValue) else { return .zero }
    let price: Price = .from(doubleValue)
    return items.total / allSubtotal * price
  }
}

fileprivate extension Array where Element == ReceiptItem {
  var total: Price {
    .from(reduce(0.0, { $0 + $1.cost }))
  }
}

// Stubbing
extension FinalizedSplitBillViewModel {
  private convenience init() {
    let people: [Person] = .stub()
    let split: [Person: [ReceiptItem]] = people.reduce(into: [:]) { $0[$1] = .stub() }
    self.init(split: split)
  }
  
  static let stub: FinalizedSplitBillViewModel = .init()
}
