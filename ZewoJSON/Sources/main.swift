import HTTPServer
import JSON


#if os(Linux)
    import SwiftGlibc
    
    public func arc4random_uniform(_ max: UInt32) -> Int32 {
        return (SwiftGlibc.rand() % Int32(max-1)) + 1
    }
#endif

let app = BasicRouter { route in
    route.get("json") { request in

        let jsonString = JSON(JSONCreator().generateJSON())

        return Response(body: "\(jsonString)")
    }
}

try HTTPServer.Server(configuration: ["tcp": ["host": "0.0.0.0", "port": 8282, "reusePort": true], "log": false], responder: app).start()
