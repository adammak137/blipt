import SwiftUI

struct AppButtonStyle: ButtonStyle {
  let backgroundColor: Color
  let foregroundColor: Color
  let cornerRadius: CGFloat
  
  init(backgroundColor: Color = Color.blue, foregroundColor: Color = Color.white, cornerRadius: CGFloat = 12) {
    self.backgroundColor = backgroundColor
    self.foregroundColor = foregroundColor
    self.cornerRadius = cornerRadius
  }
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .background(backgroundColor)
      .foregroundColor(foregroundColor)
      .cornerRadius(cornerRadius)
      .scaleEffect(configuration.isPressed ? 0.95 : 1)
      .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
  }
}

extension Button {
  func appButtonStyle(backgroundColor: Color = Color.blue, foregroundColor: Color = Color.white, cornerRadius: CGFloat = 12) -> some View {
    self.buttonStyle(AppButtonStyle(backgroundColor: backgroundColor, foregroundColor: foregroundColor, cornerRadius: cornerRadius))
  }
}

struct FancyButtonStyle_Previews: PreviewProvider {
  struct ContentView: View {
    var body: some View {
      VStack {
        Button(action: {
          print("Fancy button tapped!")
        }) {
          Text("Fancy Button")
        }
        .appButtonStyle()
        
        Button(action: {
          print("Another fancy button tapped!")
        }) {
          Text("Another Fancy Button")
        }
        .appButtonStyle(backgroundColor: Color(.systemIndigo), cornerRadius: 8)
      }
      .padding()
    }
  }
  static var previews: some View {
    ContentView()
  }
}
