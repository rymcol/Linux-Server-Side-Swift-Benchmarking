import Vapor

#if os(Linux)
    import SwiftGlibc
#else
    import Darwin
#endif

struct JSONCreator {
    func generateJSON() -> [String: Node] {
        
        var finalJSON = [String: Node]()
        
        for i in 1...10 {
            let randomNumber = Int(arc4random_uniform(UInt32(1000)))
            finalJSON["Test Number \(i)"] = Node(randomNumber)
        }
        
        return finalJSON
    }
}
