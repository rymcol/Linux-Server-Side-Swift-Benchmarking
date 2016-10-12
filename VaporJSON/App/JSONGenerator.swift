import Core

#if os(Linux)
    import SwiftGlibc
#else
    import Darwin
#endif

struct JSONCreator {
    func generateJSON() -> [String: Int] {
        
        var finalJSON = [String: Int]()
        
        for i in 1...10 {
            let randomNumber = Int(arc4random_uniform(UInt32(1000)))
            finalJSON["Test Number \(i)"] = randomNumber
        }
        
        return finalJSON
    }
}
