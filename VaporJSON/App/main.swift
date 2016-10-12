import HTTP
import HTTPRouting
import Transport
import TypeSafeRouting
import Foundation
import JSON

#if os(Linux)
    import SwiftGlibc
    
    public func arc4random_uniform(_ max: UInt32) -> Int32 {
        return (SwiftGlibc.rand() % Int32(max-1)) + 1
    }
#endif

final class App: HTTP.Responder {
    let router: Router
    let port = 8321
    
    init() {
        router = Router()
        
        router.get("json") { req in
            
            var json: Bytes = "{ ".bytes
            
            for (key, value) in JSONCreator().generateJSON() {
                json += "\"".bytes
                json += key.bytes
                json += "\"".bytes
                json += " : ".bytes
                json += String(value).bytes
                json += ", ".bytes
            }
            
            json += " }".bytes
            
            return Response(status: .ok, headers: [
                "Content-Type": "application/json; charset=utf-8"
                ], body: json)
        }
    }
    
    func respond(to request: Request) throws -> Response {
        if let handler = router.route(request, with: request) {
            return try handler.respond(to: request)
        } else {
            return Response(status: .notFound, body: "Not found.")
        }
    }
}

let app = App()

let server = try Server<TCPServerStream, Parser<Request>, Serializer<Response>>(port: app.port)

print("visit http://localhost:\(app.port)/")
try server.start(responder: app) { error in
    print("Got error: \(error)")
}
