import Foundation
import SwiftUI // Transferable
import UniformTypeIdentifiers

struct ReceiptItem: Identifiable, Equatable, Codable {
  var id: UUID = .init()
  let name: String
  let cost: Double
}

extension ReceiptItem {
  static func generate() -> ReceiptItem {
    let names = ["Coffee", "Sandwich", "Salad", "Burger", "Pizza", "Soda", "Beer", "Wine", "Ice Cream", "Cake"]
    let name = names.randomElement() ?? "Unknown"
    let cost = Double.random(in: 1.0...20.0).rounded(toPlaces: 2)
    return ReceiptItem(name: name, cost: cost)
  }
}

extension Array where Element == ReceiptItem {
  static func stub(in range: ClosedRange<Int> = 5...10) -> [ReceiptItem] {
    (0..<Int.random(in: range)).map { _ in ReceiptItem.generate() }
  }
}

extension ReceiptItem: Transferable {
  static let transferrableIdentifer: String = "com.baksha97.blipt.receiptitem"
  static var transferRepresentation: some TransferRepresentation {
    CodableRepresentation(contentType: UTType(exportedAs: transferrableIdentifer))
  }
}
