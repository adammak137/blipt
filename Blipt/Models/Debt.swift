import Foundation

struct Debt: Hashable, Codable {

  let person: Person
  let items: [Item]
  let tip: Price
  let tax: Price

  var subtotal: Price {
    items.reduce(.zero, { $0 + $1.price })
  }
  
  var grandTotal: Price {
    subtotal + tip + tax
  }
}
