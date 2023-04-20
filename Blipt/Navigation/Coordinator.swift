//import SwiftUI
//
//class Coordinator: ObservableObject {
//  
//  static let shared: Coordinator = Coordinator()
//  private init(){}
//  
//  @Published var currentScreen: Screen = .receiptBuilder(items: [])
//  
//  func showSplitBillScreen(withItems items: [ReceiptItem]) {
//    self.currentScreen = .splitBill(items: items)
//  }
//  
//  func hideSplitBillScreen() {
//    self.currentScreen = .receiptBuilder(items: [])
//  }
//}
//
//
//extension Coordinator {
//  enum Screen {
//    case receiptBuilder(items: [ReceiptItem])
//    case splitBill(items: [ReceiptItem])
//  }
//  
//  extension Screen {
//    @ViewBuilder
//    var screen: some View {
//      switch self {
//      case .receiptBuilder(let items):
//        return ReceiptBuilderScreenView(items: items)
//      case .splitBill(let items)
//        return SplitBillScreenView(viewModel: .init(people: [], receipt: items))
//      }
//    }
//  }
//}
//
//extension Coordinator {
//  struct RootView: View {
//    @ObservedObject var coordinator: Coordinator
//    
//    
//    var body: some View {
//      VStack {
//        Button("Show Split Bill Screen") {
//          coordinator.showSplitBillScreen(withItems: [])
//        }
//        NavigationLink(destination: SplitBillScreenView(viewModel: SplitBillViewModel(people: [], receipt: []),
//                                                        coordinator: coordinator),
//                       tag: Screen.splitBill(items: []),
//                       selection: $coordinator.currentScreen) {
//          EmptyView()
//        }
//      }
//    }
//  }
//}
//
