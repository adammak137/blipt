import SwiftUI

struct FinalizedSplitView: View {
  @State private var totalTipAmount: String = ""
  @State private var totalTaxAmount: String = ""
  
  var split: [Person: [ReceiptItem]]
  
  private func totalCost(for person: Person) -> Double {
    return split[person]?.reduce(0.0, { $0 + $1.cost }) ?? 0.0
  }
  
  private func tipAmount(for person: Person) -> Double {
    if let totalTip = Double(totalTipAmount),
       let personTotal = split[person]?.reduce(0.0, { $0 + $1.cost }) {
      let totalCost = split.values.flatMap({ $0 }).reduce(0.0, { $0 + $1.cost })
      return personTotal / totalCost * totalTip
    }
    return 0.0
  }
  
  private func taxAmount(for person: Person) -> Double {
    if let totalTax = Double(totalTaxAmount),
       let personTotal = split[person]?.reduce(0.0, { $0 + $1.cost }) {
      let totalCost = split.values.flatMap({ $0 }).reduce(0.0, { $0 + $1.cost })
      return personTotal / totalCost * totalTax
    }
    return 0.0
  }
  
  private func grandTotal(for person: Person) -> Double {
    return totalCost(for: person) + tipAmount(for: person) + taxAmount(for: person)
  }
  
  var body: some View {
    NavigationView {
      VStack {
        HStack {
          Text("Total Tip Amount:")
          TextField("$0.00", text: $totalTipAmount)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.decimalPad)
        }
        .padding()
        
        HStack {
          Text("Total Tax Amount:")
          TextField("$0.00", text: $totalTaxAmount)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.decimalPad)
        }
        .padding()
        
        List {
          ForEach(Array(split.keys), id: \.id) { person in
            Section(header: Text("\(person.name)'s Items")) {
              ForEach(split[person] ?? [], id: \.id) { item in
                HStack {
                  Text(item.name)
                  Spacer()
                  Text("\(item.price.description)")
                }
              }
              VStack(alignment: .leading, spacing: 8) {
                HStack {
                  Text("Subtotal")
                    .font(.headline)
                  Spacer()
                  Text("\(Price(amount: totalCost(for: person)).description)")
                    .font(.headline)
                }
                
                HStack {
                  Text("Tip")
                    .font(.headline)
                  Spacer()
                  Text("\(Price(amount: tipAmount(for: person)).description)")
                    .font(.headline)
                }
                
                HStack {
                  Text("Tax")
                    .font(.headline)
                  Spacer()
                  Text("\(Price(amount: taxAmount(for: person)).description)")
                    .font(.headline)
                }
                
                HStack {
                  Text("Total")
                    .font(.headline)
                  Spacer()
                  Text("\(Price(amount: grandTotal(for: person)).description)")
                    .font(.headline)
                }
              }
            }
          }
        }
        .listStyle(GroupedListStyle())
      }
      .navigationTitle("Split Receipt")
    }
  }
}

struct SplitView_Previews: PreviewProvider {
  static var previews: some View {
    let person1 = Person(name: "Alice")
    let person2 = Person(name: "Bob")
    
    let items1: [ReceiptItem] = [
      ReceiptItem(name: "Coffee", cost: 3.50),
      ReceiptItem(name: "Bagel", cost: 2.25)
    ]
    
    let items2: [ReceiptItem] = [
      ReceiptItem(name: "Tea", cost: 2.75),
      ReceiptItem(name: "Muffin", cost: 1.75)
    ]
    
    let split: [Person: [ReceiptItem]] = [
      person1: items1,
      person2: items2
    ]
    
    FinalizedSplitView(split: split)
  }
}
