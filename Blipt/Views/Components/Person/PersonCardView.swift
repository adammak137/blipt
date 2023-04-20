//
//  PersonCardView.swift
//  Blipt
//
//  Created by Travis Baksh on 4/17/23.
//

import SwiftUI

struct PersonCardView: View {
  
  typealias OnItemDropped = (ReceiptItem) -> ()
  
  @State private var isExpanded = false
  
  let person: Person
  let items: [ReceiptItem]
  let onItemDroppedIn: OnItemDropped?
  
  var cashTotalDescription: String {
    String(format: "$%.2f", items.map(\.cost).reduce(0, +))
  }
  
  var amountOfItemsDescription: String {
    "\(items.count) items"
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Text(person.name)
          .font(.headline)
          .fontWeight(.bold)
        
        Spacer()
        Plate()
          .fill(Color(red: 230/255, green: 230/255, blue: 230/255))
          .frame(width: 48, height: 48)
          .overlay(
            Plate()
              .stroke(Color.gray, lineWidth: 2)
              .frame(width: 24, height: 24)
          )
      }
      
      HStack {
        Text(cashTotalDescription)
          .font(.subheadline)
          .foregroundColor(.gray)
        Spacer()
        Text(amountOfItemsDescription)
          .font(.subheadline)
          .foregroundColor(.gray)
      }
    }
    .padding()
    .background(Color.white)
    .cornerRadius(10)
    .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 0, y: 4)
    .dropDestination(for: ReceiptItem.self) { items, location in
      guard let item = items.first else { return false }
      onItemDroppedIn?(item)
      return true
    }
  }
}



struct PersonCardView_Previews: PreviewProvider {
  static var previews: some View {
    PersonCardView(
      person: .init(name: "Preview"),
      items: .stub(),
      onItemDroppedIn: nil
    )
  }
}
