import SwiftUI

struct ReceiptBuilderScreenView: View {
  typealias OnBuildComplete = ([Item]) -> ()
  
  @State var items: [Item]
  let onBuildComplete: OnBuildComplete
  
  @State private var currentName: String = ""
  @State private var currentCost: Price = .zero
  @State private var plateOffset: CGSize = .zero
  
  @EnvironmentObject
  private var keyboardResponder: KeyboardResponder

  
  @ViewBuilder
  var tableButton: some View {
    NavigationLink {
      ReceiptView(title: "Current Items", items: items) { item in
        items.removeAll { $0.id == item.id }
      }
    } label: {
      ItemTableView(itemCount: items.count)
    }
  }
  
  @ViewBuilder
  var nextScreenButton: some View {
    Button("Done") {
      onBuildComplete(items)
    }.buttonStyle(AppButtonStyle())
  }
  
  var body: some View {
    VStack {
      tableButton
      Spacer()
      PlateView(cost: currentCost)
        .offset(plateOffset)
        .gesture(
          DragGesture()
            .onChanged { value in
              plateOffset = value.translation
            }
            .onEnded { value in
              if isOnTable(value.translation) && currentCost.amount > 0 {
                let defaultName = "Item \(items.count)"
                items.append(
                  Item(
                    name: currentName.isBlank ? defaultName : currentName,
                    cost: currentCost.amount
                  )
                )
              }
              plateOffset = .zero
            }
        )
      TextField("Item name", text: $currentName)
        .textFieldStyle(RoundedBorderTextFieldStyle())
      NumberPadView { button in
        handleButtonPress(button)
      }
      nextScreenButton
    }
    .padding()
  }
  
  func isOnTable(_ translation: CGSize) -> Bool {
    return translation.height < -50 && abs(translation.width) < 100
  }
  
  func handleButtonPress(_ button: String) {
    switch button {
    case "⌫":
      currentCost.amount = (currentCost.amount / 10).rounded(toPlaces: 2)
    default:
      if let number = Double(button), currentCost.amount < 9999.99 {
        currentCost.amount = currentCost.amount * 10 + number * 0.01
      }
    }
  }
}

struct ReceiptBuilderView_Previews: PreviewProvider {
  static var previews: some View {
    ReceiptBuilderScreenView(
      items: .stub()
    ) { _ in }
  }
}
