import HTTPServer
//import Router
import JSON


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

        let jsonString = JSON(JSONCreator().generateJSON())

        return Response(body: "\(jsonString)")
    }

    //serves static files
    route.get("/*", responder: FileResponder(path: "webroot/"))
}

try HTTPServer.Server(host: "0.0.0.0", port: 8282, responder: app).start()
