import SwiftUI
import Combine

class KeyboardResponder: ObservableObject {
    private var cancellables = Set<AnyCancellable>()

    @Published var isVisible = false

    init() {
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { [weak self] notification in
                self?.isVisible = true
            }
            .store(in: &cancellables)

        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self] notification in
                self?.isVisible = false
            }
            .store(in: &cancellables)
    }
}
