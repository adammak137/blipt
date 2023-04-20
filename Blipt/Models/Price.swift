import Foundation

struct Price: Codable, Equatable {
  var amount: Double
}

extension Price {
  static let zero = Price(amount: 0)
}

extension Price: CustomStringConvertible {
  var description: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = 2
    
    let number = NSNumber(value: amount)
    return formatter.string(from: number)!
  }
}
