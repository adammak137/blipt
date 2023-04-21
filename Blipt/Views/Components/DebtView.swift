import SwiftUI

struct DebtView: View {
  let debt: Debt
  
  var body: some View {
    Group {
      Section(header: Text("\(debt.person.name)'s Items")) {
        ForEach(debt.items, id: \.id) { item in
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
            Text("\(debt.subtotal.description)")
              .font(.headline)
          }
          
          HStack {
            Text("Tip")
              .font(.headline)
            Spacer()
            Text("\(debt.tip.description)")
              .font(.headline)
          }
          
          HStack {
            Text("Tax")
              .font(.headline)
            Spacer()
            Text("\(debt.tax.description)")
              .font(.headline)
          }
          
          HStack {
            Text("Total")
              .font(.headline)
            Spacer()
            Text("\(debt.grandTotal.description)")
              .font(.headline)
          }
        }
      }
    }
  }
}

struct DebtView_Previews: PreviewProvider {
  static var previews: some View {
    DebtView(
      debt: Debt(
        person: .init(name: "Preview"),
        items: .stub(),
        tip: .from(2.3),
        tax: .from(5.3)
      )
    )
  }
}
