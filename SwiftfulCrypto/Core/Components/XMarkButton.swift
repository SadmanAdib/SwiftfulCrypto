//
//  XMarkButton.swift
//  SwiftfulCrypto
//
//  Created by Sadman Adib on 13/10/22.
//

import SwiftUI

struct XMarkButton: View {
    // presentation mode was not working. So cannot use it as a component yet.
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        Button {
            vm.showPortfolioView = false
            vm.showSettingsView = false
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
