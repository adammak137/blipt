//
//  ReceiptItemView.swift
//  Blipt
//
//  Created by Travis Baksh on 4/17/23.
//

import SwiftUI

struct ReceiptItemView: View {
  let item: Item
  
  var body: some View {
    HStack {
      Text(item.name)
        .font(.headline)
      Spacer()
      Text("$\(item.cost, specifier: "%.2f")")
    }
  }
}

struct ReceiptItemView_Previews: PreviewProvider {
    static var previews: some View {
      ReceiptItemView(item: .generate())
    }
}
