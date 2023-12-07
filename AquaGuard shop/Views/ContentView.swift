import SwiftUI

struct ContentView: View {
    @StateObject var cartManager = CartManager()
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    @ObservedObject var viewModel: ProductViewModel
    
    init(viewModel: ProductViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.productList ?? [], id: \.id) { product in
                        ProductCard(viewModel: viewModel, product: product)
                            .environmentObject(cartManager)
                    }
                }
                .padding()
            }
            .navigationTitle(Text("AquaGuard Shop"))
            .toolbar {
                NavigationLink {
                    CartView()
                        .environmentObject(cartManager)
                } label: {
                    CartButton(numberOfProducts: cartManager.products.count)
                }
            }
            .background(Image("background_splash_screen")
                .resizable()
                .scaledToFill()
                    .edgesIgnoringSafeArea(.all))
        }.onAppear(){
            Task{
                viewModel.fetchProducts()
                print("sdfdsfsfsdfdsfsfsdfsdfsdfsdf")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProductViewModel()
        viewModel.productList = []
        
        ContentView(viewModel: viewModel)
    }
}*/
