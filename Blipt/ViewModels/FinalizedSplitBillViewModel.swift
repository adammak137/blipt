import Foundation

class FinalizedSplitBillViewModel: ObservableObject {
  
  @Published var totalTipAmount: String = ""
  @Published var totalTaxAmount: String = ""
  
  let split: [Person: [ReceiptItem]]
 
  init(split: [Person: [ReceiptItem]]) {
    self.split = split
  }
  
  func subtotalCost(for person: Person) -> Price {
    let subtotal = split[person]?.reduce(0.0, { $0 + $1.cost }) ?? 0.0
    
    return .init(amount: subtotal)
  }
  
  func tipAmount(for person: Person) -> Price {
    if let totalTip = Double(totalTipAmount),
       let personTotal = split[person]?.reduce(0.0, { $0 + $1.cost }) {
      let totalCost = split.values.flatMap({ $0 }).reduce(0.0, { $0 + $1.cost })
      let tip = personTotal / totalCost * totalTip
      return .init(amount: tip)
    }
    return .zero
  }
  
  func taxAmount(for person: Person) -> Price {
    if let totalTax = Double(totalTaxAmount),
       let personTotal = split[person]?.reduce(0.0, { $0 + $1.cost }) {
      let totalCost = split.values.flatMap({ $0 }).reduce(0.0, { $0 + $1.cost })
      let tax = (personTotal / totalCost * totalTax)
      return .init(amount: tax)
    }
    return .zero
  }
  
  func grandTotal(for person: Person) -> Price {
    return subtotalCost(for: person) + tipAmount(for: person) + taxAmount(for: person)
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
