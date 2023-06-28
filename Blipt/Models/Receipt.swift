import Foundation

struct Receipt: Codable {
  typealias Split = [Person: [Item]]
  let split: Split
  let tax: Price
  let tip: Price
}
