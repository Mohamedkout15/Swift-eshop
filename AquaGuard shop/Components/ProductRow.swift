//
//  ProductRow.swift
//  AquaGuard shop
//
//  Created by Mohamed Kout on 30/11/2023.
//

import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var cartManager: CartManager
    @ObservedObject var viewModel: ProductViewModel
    var product: Product?

    var body: some View {
        HStack(spacing: 20) {
            if let product = product {
               Image(product.image)
                  .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 50)
                  .cornerRadius(10)

                VStack(alignment: .leading, spacing: 10) {
                    Text(product.name)
                        .bold()

                    Text("$\(product.price)")
                }

                Spacer()

                Image(systemName: "trash")
                    .foregroundColor(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                    .onTapGesture {
                        cartManager.removeFromCart(product: product)
                    }
            } else {
                Text("No product data")
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProductViewModel()
        viewModel.productList = []
        let cartManager = CartManager()

        return Group {
            ProductRow(viewModel: viewModel, product: viewModel.productList?.first)
                .environmentObject(cartManager)

            ProductRow(viewModel: viewModel, product: nil)
                .environmentObject(cartManager)
        }
    }
}
