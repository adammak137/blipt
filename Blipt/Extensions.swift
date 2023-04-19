//
//  Extensions.swift
//  Blipt
//
//  Created by Travis Baksh on 4/17/23.
//

import Foundation
import SwiftUI
import NumberTextField

extension String {
    var isBlank: Bool {
        return allSatisfy({ $0.isWhitespace })
    }
}

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


extension NumberFormatter {
  static var currency: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale.current
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 0
    return formatter
  }
}

extension NumberTextField {
  init(_ placeholder: String, value: Binding<Decimal?>) {
    self.init(placeholder: placeholder, value: value, formatter: .currency, isActive: .constant(true)) { _ in }
  }
}
