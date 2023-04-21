import Foundation

class DebtViewModel: ObservableObject {
  
  @Published var totalTipAmount: String = "" {
    didSet { updateDebts() }
  }
  
  @Published var totalTaxAmount: String = "" {
    didSet { updateDebts() }
  }
  
  var allSubtotal: Price {
    let allSubtotal: Price = split.values.map{ $0.total }.reduce(.zero, { $0 + $1 })
    return allSubtotal
  }
  
  var grandTotal: Price {
    let totalTip = Double(totalTipAmount) ?? 0
    let totalTax = Double(totalTaxAmount) ?? 0
    return allSubtotal + .from(totalTip) + .from(totalTax)
  }
  
  @Published var debts: [Debt] = []
  
  private let split: [Person: [Item]]
  
  init(split: [Person: [Item]]) {
    self.split = split
    updateDebts()
  }
  
  private func updateDebts() {
    
    debts = split.map { person, items in
      Debt(
        person: person,
        items: items,
        tip: calculateAmount(amountStringValue: totalTipAmount, items: items, allSubtotal: allSubtotal),
        tax: calculateAmount(amountStringValue: totalTaxAmount, items: items, allSubtotal: allSubtotal)
      )
    }
  }
  
  private func calculateAmount(amountStringValue: String, items: [Item], allSubtotal: Price) -> Price {
    guard let doubleValue = Double(amountStringValue) else { return .zero }
    let price: Price = .from(doubleValue)
    return items.total / allSubtotal * price
  }
}

fileprivate extension Array where Element == Item {
  var total: Price {
    .from(reduce(0.0, { $0 + $1.cost }))
  }
}

// Stubbing
extension DebtViewModel {
  private convenience init() {
    let people: [Person] = .stub()
    let split: [Person: [Item]] = people.reduce(into: [:]) { $0[$1] = .stub() }
    self.init(split: split)
  }
  
  static let stub: DebtViewModel = .init()
}
