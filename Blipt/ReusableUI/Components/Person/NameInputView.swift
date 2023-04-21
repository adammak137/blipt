import SwiftUI

struct NameInputView: View {
  typealias NameInputViewCallback = (String) -> Void
  
  let callback: NameInputViewCallback
  @State private var name = ""
  
  var body: some View {
      HStack {
          TextField("Enter your name", text: $name)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .padding(.horizontal)
          Button(action: {
            callback(name)
            name = ""
          }) {
              Image(systemName: "plus.circle.fill")
                  .font(.system(size: 24))
                  .foregroundColor(.blue)
          }
      }
      .padding()
  }
}

struct PersonInputView_Previews: PreviewProvider {
    static var previews: some View {
      NameInputView() { _ in }
    }
}
