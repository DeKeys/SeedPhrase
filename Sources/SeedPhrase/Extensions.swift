//
//  Extensions.swift
//  
//
//  Created by Олег Рыбалко on 04.07.2022.
//

import Foundation

typealias Byte = UInt8
typealias ByteArray = [Byte]

// https://gist.github.com/pofat/6ae0c2626660741234f159c60f51af91
extension Data {
    var bytes: [Byte] {
        var byteArray = [UInt8](repeating: 0, count: self.count)
        self.copyBytes(to: &byteArray, count: self.count)
        return byteArray
    }
}

extension Byte {
    var bits: BitArray {
        let bitsOfAbyte = 8
        var bitsArray = BitArray(repeating: Bit.zero, count: bitsOfAbyte)
        for (index, _) in bitsArray.enumerated() {
            // Bitwise shift to clear unrelevant bits
            let bitVal: UInt8 = 1 << UInt8(bitsOfAbyte - 1 - index)
            let check = self & bitVal
            
            if check != 0 {
                bitsArray[index] = Bit.one
            }
        }
        return bitsArray
    }
}
