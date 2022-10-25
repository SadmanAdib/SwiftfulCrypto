//
//  String.swift
//  SwiftfulCrypto
//
//  Created by Sadman Adib on 25/10/22.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
