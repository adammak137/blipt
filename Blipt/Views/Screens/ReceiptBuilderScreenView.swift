import SwiftUI

struct ReceiptBuilderScreenView<Destination>: View where Destination : View {
  typealias ReceiptBuilderContentDestination = ([ReceiptItem]) -> Destination
  let destination: ReceiptBuilderContentDestination?
  @State var items: [ReceiptItem]
  @State private var currentCost: Price = .zero
  @State private var plateOffset: CGSize = .zero
  
  init(items: [ReceiptItem]) {
    self.items = items
    self.destination = nil
  }
  
  init(items: [ReceiptItem], @ViewBuilder destination: @escaping ReceiptBuilderContentDestination) {
    self.items = items
    self.destination = destination
  }
  
  @ViewBuilder
  var tableButton: some View {
    NavigationLink {
      ReceiptView(title: "Current Items", items: items) { item in
        items.removeAll { $0.id == item.id }
      }
    } label: {
      TableDrawingView(itemCount: items.count)
    }
  }
  
  @ViewBuilder
  var nextScreenButton: some View {
    NavigationLink {
      destination?(items)
    } label: {
      Text("Done")
        .frame(maxWidth: .infinity)
    }.buttonStyle(FancyButtonStyle())
  }
  
  var body: some View {
    NavigationStack {
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
                  items.append(ReceiptItem(name: "Item \(items.count)", cost: currentCost.amount))
                }
                plateOffset = .zero
              }
          )
        NumberPadView { button in
          handleButtonPress(button)
        }
        nextScreenButton
      }
      .padding()
    }
  }
  
  func isOnTable(_ translation: CGSize) -> Bool {
    return translation.height < -50 && abs(translation.width) < 100
  }
  
  func handleButtonPress(_ button: String) {
    switch button {
    case "⌫":
      currentCost.amount = (currentCost.amount / 10).rounded(toPlaces: 2)
    case ".":
      break // ignore decimal since we already handle decimal values
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
      items: .stub(),
      destination: { items in Text("Next Screen Sample with: \(items.count)") }
    )
  }
}

struct TableDrawing: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    path.addRoundedRect(in: rect, cornerSize: CGSize(width: 5, height: 5))
    
    let legHeight: CGFloat = 60
    let legWidth: CGFloat = 15
    let yOffset = rect.height - legHeight / 2
    
    for i in 0...1 {
      let xOffset = rect.width * (i == 0 ? 0.25 : 0.75) - legWidth / 2
      let legRect = CGRect(x: xOffset, y: yOffset, width: legWidth, height: legHeight)
      path.addRoundedRect(in: legRect, cornerSize: CGSize(width: 3, height: 3))
    }
    
    return path
  }
}

struct TableDrawingView: View {
  var itemCount: Int
  
  var body: some View {
    ZStack {
      TableDrawing()
        .fill(Color.cyan)
        .frame(width: 200, height: 100)
      Text("\(itemCount) items")
        .font(.headline)
        .foregroundColor(.black )
      
    }
  }
}

struct PlateView: View {
  var cost: Price
  var body: some View {
    VStack {
      Image(systemName: "circle.grid.hex")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 80, height: 80)
        .foregroundColor(.gray)
      Text(cost.description)
        .font(.system(size: 24))
        .padding()
    }
  }
}
struct NumberPadView: View {
  var input: (String) -> Void
  
  private let buttons = [
    ["1", "2", "3"],
    ["4", "5", "6"],
    ["7", "8", "9"],
    [" ", "0", "⌫"]
  ]
  
  var body: some View {
    VStack(spacing: 8) {
      ForEach(buttons, id: \.self) { row in
        HStack(spacing: 8) {
          ForEach(row, id: \.self) { button in
            Button(action: {
              input(button)
            }) {
              Text(button)
                .font(.system(size: 24))
                .frame(width: 100, height: 100)
                .background(Color.gray.opacity(0.1))
            }
          }
        }
      }
    }
  }
}
