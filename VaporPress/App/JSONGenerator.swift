import Vapor

#if os(Linux)
import Glibc
#else
import Darwin
#endif

struct JSONCreator {
    func generateJSON() -> Node {

        var finalJSON = [String: Node]()

        for i in 1...10 {
            let randomNumber = Int(arc4random_uniform(UInt32(1000)))
            finalJSON["Test Number \(i)"] = Node(randomNumber)
        }

        return Node(finalJSON)
    }
}
