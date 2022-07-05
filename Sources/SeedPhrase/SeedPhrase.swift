import Foundation
import CryptoKit

@available(macOS 10.15, iOS 13, *)
public struct SeedPhrase: SeedPhraseProtocol {
    /// This function returns the entropy from the mnemonic seed phrase
    ///
    /// - Parameter phrase: array of words representing mnemonic
    /// - Throws: throws an error if any word can't be found in bip39 wordlist or if checksum is invalid
    /// - Returns: entropy in Data format
    static func rawRepresentation(from phrase: Phrase) throws -> Data? {
        var resBits = BitArray()
        
        for word in phrase {
            if let wordIndex = bip39.firstIndex(of: word) {
                resBits += BitArray(from: String(wordIndex, radix: 2), length: 11)
            } else {
                throw SeedPhraseError.invalidWord
            }
        }
        
        let entropyBytes = try ByteArray(from: BitArray(resBits[0..<256]))
        let entropyData = Data(bytes: entropyBytes, count: entropyBytes.count)
        
        // Check if checksum is valid for this entropy
        var hasher = SHA256()
        hasher.update(data: entropyData)
        
        let checksumBytes = withUnsafeBytes(of: hasher.finalize().hashValue) { Data($0) }.bytes
        let checksumBits = BitArray(from: checksumBytes)
        
        let length = resBits.count - 256
       
        if length > 0 && checksumBits[0..<length] != resBits[256..<resBits.count] {
            throw SeedPhraseError.invalidChecksum
        }
        
        return entropyData
    }
    
    /// This function creates a mnemonic seed phrase from given data
    ///
    /// - Parameter data: data from which to create a mnemonic (length in bits should be divisible by 32)
    /// - Throws: invalid length of data
    /// - Returns: array of words representing a mnemonic
    static func derive(from data: Data?) throws -> Phrase {
        guard let data = data else { return [] }
        if (data.count * 8) % 32 != 0 {
            throw SeedPhraseError.invalidLength
        }
        
        // Convert key to bits
        var keyBits = BitArray(from: data.bytes)
        
        // Create checksum and convert it to bits
        var hash = SHA256()
        hash.update(data: data)
        let checksumData: Data = withUnsafeBytes(of: hash.finalize().hashValue) { Data($0) }
        let checksumBits = BitArray(from: checksumData.bytes)
        
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
