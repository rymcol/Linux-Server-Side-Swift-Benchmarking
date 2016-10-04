import Axis

#if os(Linux)
import SwiftGlibc
#else
import Darwin
#endif

struct JSONCreator {
    func generateJSON() -> Map {

        var finalJSON = [String: Map]()

        for i in 1...10 {
            let randomNumber = Int(arc4random_uniform(UInt32(1000)))
            finalJSON["Test Number \(i)"] = .int(randomNumber)
        }

        return .dictionary(finalJSON)
    }
}
