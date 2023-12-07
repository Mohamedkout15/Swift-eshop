import SwiftUI

struct ProductCard: View {
    @EnvironmentObject var cartManager: CartManager
    @ObservedObject var viewModel: ProductViewModel
    var product: Product?
    
    var body: some View {
        if let product = product {
            ZStack(alignment: .topTrailing) {
                ZStack(alignment: .bottom) {
                    AsyncImage(url: URL(string: "http://172.18.26.15:9090/images/produit/\( product.image)"))
                      .cornerRadius(20)
                      .frame(width: 180)
                      .scaledToFit()

                    VStack(alignment: .leading) {
                        Text(product.name)
                            .bold()

                        Text("\(product.price)PT")
                            .font(.caption)
                    }
                    .padding()
                    .frame(width: 180, alignment: .leading)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                }
                .frame(width: 180, height: 250)
                .shadow(radius: 3)

                Button {
                    cartManager.addToCart(product: product)
                } label: {
                    Image(systemName: "plus")
                        .padding(10)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(50)
                        .padding()
                }
            }
        } else {
            Text("No product data")
        }
    }
}

struct ProductCard_Previews: PreviewProvider {
  static var previews: some View {
      let viewModel = ProductViewModel()
      viewModel.productList = []
      let cartManager = CartManager()

      return Group {
          HStack(spacing: 20) {
              ProductCard(viewModel: viewModel, product: viewModel.productList?.first)
                .environmentObject(cartManager)

              ProductCard(viewModel: viewModel, product: nil)
                .environmentObject(cartManager)
          }
      }
  }
}
