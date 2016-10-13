import HTTP
import HTTPRouting
import Transport
import TypeSafeRouting
import Foundation

#if os(Linux)
import SwiftGlibc

public func arc4random_uniform(_ max: UInt32) -> Int32 {
    return (SwiftGlibc.rand() % Int32(max-1)) + 1
}
#endif

final class App: HTTP.Responder {
    let router: Router
    let port = 8321
    let file: FileManager
    
    init() {
        router = Router()
        file = FileManager()
        
        router.get { req in
            let header = CommonHandler().getHeader()
            let footer = CommonHandler().getFooter()
            let body = IndexHandler().loadPageContent()
            let indexPage = header + body + footer
            
            return Response(status: .ok, headers: [
                "Content-Type": "text/html; charset=utf-8"
            ], body: indexPage)
        }
        
        router.get("blog") { req in
            let header = CommonHandler().getHeader()
            let footer = CommonHandler().getFooter()
            let body = BlogPageHandler().loadPageContent()
            let blogPage = header + body + footer
            
            return Response(status: .ok, headers: [
                "Content-Type": "text/html; charset=utf-8"
            ], body: blogPage)
        }
    }
    
    func respond(to request: Request) throws -> Response {
        if let handler = router.route(request, with: request) {
            return try handler.respond(to: request)
        } else {
            // Check in file system
            let filePath = "/home/ryan/Developer/Server-Side-Swift-Benchmarking/VaporPress/Public" + request.uri.path
            //let filePath = "/Users/tanner/Desktop/Linux-Server-Side-Swift-Benchmarking/VaporPress/Public" + request.uri.path
            
            if let contents = file.contents(atPath: filePath), file.fileExists(atPath: filePath) {
                var headers: [HeaderKey: String] = [:]
                
                if
                    let fileExtension = filePath.components(separatedBy: ".").last,
                    let type = mediaTypes[fileExtension]
                {
                    headers["Content-Type"] = type
                }
                
                return Response(status: .ok, headers: headers, body: .data(try contents.makeBytes()))
            } else {
                return Response(status: .notFound, body: "Not found.")
            }
        }
    }
}

let app = App()

let server = try Server<TCPServerStream, Parser<Request>, Serializer<Response>>(port: app.port)

print("visit http://localhost:\(app.port)/")
try server.start(responder: app) { error in
    print("Got error: \(error)")
}
