import Foundation

class SplitBillViewModel: ObservableObject {
  @Published var items: [Person: [ReceiptItem]]
  @Published var receipt: [ReceiptItem]
  
  init(people: [Person], receipt: [ReceiptItem]) {
    self.items = people.reduce(into: [Person: [ReceiptItem]]()) { $0[$1] = [] }
    self.receipt = receipt
  }
  
  func add(person: Person) {
    guard !items.contains(where: { $0.key == person }) else {
      return // person is already added, do nothing
    }
    items[person] = []
  }
  
  func add(item: ReceiptItem) {
    receipt.append(item)
  }
  
  func remove(item: ReceiptItem) {
    receipt.removeAll(where: { $0.id == item.id })
  }
  
  func add(item: ReceiptItem, to person: Person) {
    add(person: person)
    items[person]?.append(item)
    remove(item: item)
  }
  
  func remove(item: ReceiptItem, from person: Person) {
    items[person]?.removeAll(where: { $0.id == item.id })
    add(item: item)
  }
}

// Stubbing
extension SplitBillViewModel {
  fileprivate convenience init() {
    let people: [Person] = .stub()
    self.init(people: people, receipt: .stub())
    items = people.reduce(into: [Person: [ReceiptItem]]()) { result, person in
      result[person] = .stub()
    }
    receipt = .stub()
  }
  
  static let stub: SplitBillViewModel = .init()
}
