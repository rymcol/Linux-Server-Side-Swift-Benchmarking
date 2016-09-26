import Vapor
import HTTP

#if os(Linux)
    import SwiftGlibc
    
    public func arc4random_uniform(_ max: UInt32) -> Int32 {
        return (SwiftGlibc.rand() % Int32(max-1)) + 1
    }
#endif

let drop = Droplet(availableMiddleware: [:])

drop.get("json") { request in

    return try JSON(node: JSONCreator().generateJSON())
}

let port = drop.config["app", "port", "host"]?.int ?? 80

// Print what link to visit for default port
print("Visit http://localhost:\(port)")
drop.run()
