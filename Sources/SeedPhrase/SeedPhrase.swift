import Foundation
import CryptoKit

@available(macOS 10.15, *)
public struct SeedPhrase: SeedPhraseProtocol {
    static func rawRepresentation(from: Phrase) -> Data? {
        
        return nil
    }
    
    static func derive(from data: Data?) throws -> Phrase {
        guard let data = data else { return [] }
        if (data.count * 8) % 32 != 0 {
            throw SeedPhraseError.invalidLength
        }
        
        // Convert key to bits
        var keyBits = [Bit]()
        for byte in data.bytes {
            keyBits += byte.bits
        }
        
        // Create checksum and convert it to bits
        var hash = SHA256()
        hash.update(data: data)
        let checksumData: Data = withUnsafeBytes(of: hash.finalize().hashValue) { Data($0) }
        var checksumBits = [Bit]()
        
        for byte in checksumData.bytes {
            checksumBits += byte.bits
        }
        
        // Append 1 bit from checksum to key bits for every 32 bits of key
        let N = keyBits.count / 32
        if N > 0  {
            for i in 0..<N {
                keyBits.append(checksumBits[i])
            }
        }
        
        // Generate seed phrase
        var seed = Phrase()
        
        for i in stride(from: 0, to: keyBits.count, by: 11) {
            seed.append(bip39[bin2dec(Array(keyBits[i..<(i+11)]))])
        }
        
        return seed
    }
}
