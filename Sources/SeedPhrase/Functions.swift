//
//  Functions.swift
//  
//
//  Created by Олег Рыбалко on 04.07.2022.
//

import Foundation

func bin2dec(_ bits: [Bit]) -> Int {
    var res = 0
    let N = bits.count - 1
    
    for i in stride(from: N, to: -1, by: -1) {
        switch bits[i] {
        case .zero:
            break
        case .one:
            res += Int(pow(2.0, Double(N - i)))
        }
    }
    
    return res
}
