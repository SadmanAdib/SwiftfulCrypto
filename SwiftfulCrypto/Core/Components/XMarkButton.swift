//
//  XMarkButton.swift
//  SwiftfulCrypto
//
//  Created by Sadman Adib on 13/10/22.
//

import SwiftUI

struct XMarkButton: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        Button {
            vm.showPortfolioView.toggle()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
    }
}
