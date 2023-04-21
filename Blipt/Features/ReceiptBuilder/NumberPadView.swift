import SwiftUI

struct NumberPadView: View {
  var input: (String) -> Void
  
  // TODO: Remove Empty button and align the delete and 0.
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


struct NumberPadView_Previews: PreviewProvider {
    static var previews: some View {
      NumberPadView { _ in }
    }
}
