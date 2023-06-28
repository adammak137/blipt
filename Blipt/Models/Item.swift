import Foundation
import SwiftUI // Transferable
import UniformTypeIdentifiers

struct Item: Identifiable, Equatable, Codable, Hashable {
  var id: UUID = .init()
  let name: String
  var cost: Double { price.amount }
  let price: Price
  
  init(name: String, cost: Double) {
    self.name = name
    self.price = Price(amount: cost)
  }
}

extension Item {
  static func generate() -> Item {
    let names = ["Coffee", "Sandwich", "Salad", "Burger", "Pizza", "Soda", "Beer", "Wine", "Ice Cream", "Cake"]
    let name = names.randomElement() ?? "Unknown"
    let cost = Double.random(in: 1.0...20.0).rounded(toPlaces: 2)
    return Item(name: name, cost: cost)
  }
}

extension Array where Element == Item {
  static func stub(in range: ClosedRange<Int> = 5...10) -> [Item] {
    (0..<Int.random(in: range)).map { _ in Item.generate() }
  }
}

extension Item: Transferable {
  static let transferrableIdentifer: String = "com.baksha97.blipt.receiptitem"
  static let transferrableContentType: UTType = UTType(exportedAs: transferrableIdentifer)
  static var transferRepresentation: some TransferRepresentation {
    CodableRepresentation(contentType: transferrableContentType)
  }
}
