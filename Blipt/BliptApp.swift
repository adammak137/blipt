import SwiftUI

@main
struct BliptApp: App {
  var body: some Scene {
    WindowGroup {
      RootView()
        .environmentObject(KeyboardResponder())
    }
  }
}

