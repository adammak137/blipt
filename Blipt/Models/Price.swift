import Foundation

struct Price: Codable, Equatable, CustomStringConvertible {  
  var amount: Double
  
  var description: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = 2
    
    let number = NSNumber(value: amount)
    return formatter.string(from: number)!
  }
}

extension Price {
  static let zero = Price(amount: 0)
  
  static func from(_ value: Double) -> Price {
    .init(amount: value)
  }
  
  static func +(lhs: Price, rhs: Price) -> Price {
    .init(amount: lhs.amount + rhs.amount)
  }
  static func *(lhs: Price, rhs: Price) -> Price {
    .init(amount: lhs.amount * rhs.amount)
  }
  static func /(lhs: Price, rhs: Price) -> Price {
    .init(amount: lhs.amount / rhs.amount)
  }
}

