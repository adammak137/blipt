import SwiftUI

@MainActor
final class NavigationStore: ObservableObject {
  @Published var path = NavigationPath()
  
  @SceneStorage("navigation")
  private var navigationData: Data?
  
  private let decoder = JSONDecoder()
  private let encoder = JSONEncoder()
  
  init() {
    if let navigationData {
      restore(from: navigationData)
    }
    Task {
      for await _ in self.$path.values {
        navigationData = self.encoded()
      }
    }
  }

  
  private func encoded() -> Data? {
    try? path.codable.map(encoder.encode)
  }
  
  private func restore(from data: Data) {
    do {
      let codable = try decoder.decode(
        NavigationPath.CodableRepresentation.self, from: data
      )
      path = NavigationPath(codable)
    } catch {
      path = NavigationPath()
    }
  }
  
  func handle() {
    
  }
}
