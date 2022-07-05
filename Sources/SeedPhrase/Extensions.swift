//
//  Extensions.swift
//  
//
//  Created by Олег Рыбалко on 04.07.2022.
//

import Foundation

extension ByteArray {
    init(from bits: BitArray) throws {
        if bits.count % 8 != 0 {
            throw ByteArrayError.invalidLength
        }
        
        var res = ByteArray()
        
        for i in stride(from: 0, to: bits.count, by: 8) {
            res.append(Byte(bin2dec(BitArray(bits[i..<(i + 8)]))))
        }
        
        self.init(res)
    }
}

extension BitArray {
    init(from string: String?, length: Int = 0) {
        guard let string = string else {
            self.init()
            return
        }
        var res = BitArray()
        
        if length - string.count > 0 {
            for _ in 0..<(length - string.count) {
                res.append(.zero)
            }
        }
        
        res += string.map { char in
            return char == "0" ? .zero : .one
        }
        self.init(res)
    }
    
    init(from data: ByteArray) {
        self.init(data.map { $0.bits }.flatMap { $0 })
    }
}

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
