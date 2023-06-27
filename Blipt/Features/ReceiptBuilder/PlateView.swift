import SwiftUI

struct PlateView: View {
  
  let cost: Price
  
  var body: some View {
    VStack {
      Image(systemName: "circle.grid.hex")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 80, height: 80)
        .foregroundColor(.gray)
      Text(cost.description)
        .font(.headline)
        .padding()
    }
  }
}

struct PlateView_Previews: PreviewProvider {
    static var previews: some View {
      PlateView(cost: .zero)
    }
}
