import SwiftUI

struct ItemTableView: View {
  let itemCount: Int
  
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

fileprivate struct TableDrawing: Shape {
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


struct ItemTableView_Previews: PreviewProvider {
    static var previews: some View {
      ItemTableView(itemCount: 5)
    }
}

