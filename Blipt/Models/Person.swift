import Foundation

struct Person: Identifiable, Equatable, Hashable, Codable {
  let id: UUID
  let name: String  
  init(name: String) {
    self.id = .init()
    self.name = name
  }
}

extension Array where Element == Person {
  fileprivate static let names = [
    "Alice", "Bob", "Charlie", "David", "Emily", "Frank", "Grace", "Henry", "Isabella", "James", "Karen", "Laura",
    "Maggie", "Nathan", "Olivia", "Patrick", "Quincy", "Rachel", "Samuel", "Thomas",
    "Ursula", "Victoria", "William", "Xavier", "Yolanda", "Zachary"
  ]
  static func stub(in range: ClosedRange<Int> = 5...20) -> [Person] {
    (0..<Int.random(in: range))
      .map { _ in names.randomElement()! }
      .uniqued()
      .map(Person.init)
  }
}
