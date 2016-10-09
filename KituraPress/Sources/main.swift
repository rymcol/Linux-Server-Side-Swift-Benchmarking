import Kitura
import SwiftyJSON

#if os(Linux)
    import SwiftGlibc

    public func arc4random_uniform(_ max: UInt32) -> Int32 {
        return (SwiftGlibc.rand() % Int32(max-1)) + 1
    }
#endif

// All Web apps need a router to define routes
let router = Router()

router.get("/") { _, response, next in
    let header = CommonHandler().getHeader()
    let footer = CommonHandler().getFooter()
    let body = IndexHandler().generateContent()
    let homePage = header + body + footer
    try response.send(homePage).end()
}

router.get("/blog") { _, response, next in
     response.headers["Content-Type"] = "text/html; charset=utf-8"
     let header = CommonHandler().getHeader()
     let footer = CommonHandler().getFooter()
     let body = BlogHandler().loadPageContent()
     let blogPage = header + body + footer
     try response.send(blogPage).end()
}

router.get("/json") { _, response, next in
     response.headers["Content-Type"] = "application/json; charset=utf-8"
     let json = JSON(JSONCreator().generateJSON())
     try response.send(json: json).end()
}

router.get(middleware: StaticFileServer(path: "./public"))

// Handles any errors that get set
router.error { request, response, next in
    response.headers["Content-Type"] = "text/plain; charset=utf-8"
    let errorDescription: String
    if let error = response.error {
        errorDescription = "\(error)"
    } else {
        errorDescription = "Unknown error"
    }
    try response.send("Caught the error: \(errorDescription)").end()
}

// A custom Not found handler
router.all { request, response, next in
    if  response.statusCode == .unknown  {
        // Remove this wrapping if statement, if you want to handle requests to / as well
        if  request.originalURL != "/"  &&  request.originalURL != ""  {
            try response.status(.notFound).send("404! - This page does not exits!").end()
        }
    }
    next()
}

// Add HTTP Server to listen on port 8090
Kitura.addHTTPServer(onPort: 8090, with: router)

// start the framework - the servers added until now will start listening
Kitura.run()
