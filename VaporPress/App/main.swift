import Vapor
import HTTP

#if os(Linux)
import SwiftGlibc

public func arc4random_uniform(_ max: UInt32) -> Int32 {
    return (SwiftGlibc.rand() % Int32(max-1)) + 1
}
#endif

let drop = Droplet()

let _ = drop.config["app", "key"]?.string ?? ""

drop.get("/") { request in
    let header = CommonHandler().getHeader()
    let footer = CommonHandler().getFooter()
    let pageContent = IndexHandler().loadPageContent()
    let fullPage = header + footer + pageContent

    return Response(status: .ok, body: fullPage)
}

drop.get("blog") { request in
    let header = CommonHandler().getHeader()
    let footer = CommonHandler().getFooter()
    let pageContent = BlogHandler().loadPageContent()
    let fullPage = header + footer + pageContent

    return Response(status: .ok, body: fullPage)
}

drop.get("json") { request in

    return JSON(JSONCreator().generateJSON())
}

let port = drop.config["app", "port", "host"]?.int ?? 80

drop.run()
