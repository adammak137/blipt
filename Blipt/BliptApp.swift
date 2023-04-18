//
//  BliptApp.swift
//  Blipt
//
//  Created by Travis Baksh on 4/17/23.
//

import SwiftUI

@main
struct BliptApp: App {
  var body: some Scene {
    WindowGroup {
      SplitBillView(viewModel: .stub)
    }
  }
}
