import Foundation

class ReceiptSplitterViewModel: ObservableObject {
  @Published var items: [Person: [Item]]
  @Published var receipt: [Item]
  
  init(people: [Person], receipt: [Item]) {
    self.items = people.reduce(into: [Person: [Item]]()) { $0[$1] = [] }
    self.receipt = receipt
  }
  
  func add(person: Person) {
    guard !items.contains(where: { $0.key == person }) else {
      return // person is already added, do nothing
    }
    items[person] = []
  }
  
  func add(item: Item) {
    receipt.append(item)
  }
  
  func remove(item: Item) {
    receipt.removeAll(where: { $0.id == item.id })
  }
  
  func add(item: Item, to person: Person) {
    add(person: person)
    items[person]?.append(item)
    remove(item: item)
  }
  
  func remove(item: Item, from person: Person) {
    items[person]?.removeAll(where: { $0.id == item.id })
    add(item: item)
  }
}

// Stubbing
extension ReceiptSplitterViewModel {
  private convenience init() {
    let people: [Person] = .stub()
    self.init(people: people, receipt: .stub())
    items = people.reduce(into: [Person: [Item]]()) { result, person in
      result[person] = .stub()
    }
    receipt = .stub()
  }
  
  static let stub: ReceiptSplitterViewModel = .init()
}
