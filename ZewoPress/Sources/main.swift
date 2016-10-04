import HTTPServer

#if os(Linux)
import SwiftGlibc

public func arc4random_uniform(_ max: UInt32) -> Int32 {
    return (SwiftGlibc.rand() % Int32(max-1)) + 1
}
#endif

let app = BasicRouter { route in
    route.get("/") { request in

        let header = CommonHandler().getHeader()
        let footer = CommonHandler().getFooter()
        let body = IndexHandler().loadPageContent()
        let indexPage = header + body + footer

        return Response(body: indexPage)
    }

    route.get("blog") { request in

        let header = CommonHandler().getHeader()
        let footer = CommonHandler().getFooter()
        let body = BlogHandler().loadPageContent()
        let blogPage = header + body + footer

        return Response(body: blogPage)
    }

    route.get("json") { request in

        let json = JSONCreator().generateJSON()

        return Response(content: json, contentType: .json)
    }
}

let contentNegotiation = ContentNegotiationMiddleware(mediaTypes: [.json])

try Server(port: 8282, reusePort: true, middleware: [contentNegotiation], responder: app).start()
