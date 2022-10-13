//
//  UIApplication.swift
//  SwiftfulCrypto
//
//  Created by Sadman Adib on 13/10/22.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
