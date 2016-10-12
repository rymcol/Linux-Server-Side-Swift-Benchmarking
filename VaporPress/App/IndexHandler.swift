#if os(Linux)
    import Glibc
#else
    import Darwin
#endif
import Core

struct IndexHandler {
    
    func loadPageContent() -> Bytes {
        var post = "No matching post was found".bytes
        let randomContent = ContentGenerator().generate()
        
        if let firstPost = randomContent["Test Post 1"] {
            post = firstPost
        }
        
        let imageNumber = Int(arc4random_uniform(25) + 1)
        
        var finalContent = "<section id=\"content\"><div class=\"container\"><div class=\"row\"><div class=\"banner center-block\"><div><img src=\"/img/banner@2x.png\" alt=\"Swift Based Blog\" class=\"img-responsive banner center-block\" /></div> <div><img src=\"/img/random/random-1.jpg\" alt=\"Swift Based Blog\" class=\"img-responsive banner center-block\" /></div> <div><img src=\"/img/random/random-2.jpg\" alt=\"Swift Based Blog\" class=\"img-responsive banner center-block\" /></div> <div><img src=\"/img/random/random-3.jpg\" alt=\"Swift Based Blog\" class=\"img-responsive banner center-block\" /></div> <div><img src=\"/img/random/random-4.jpg\" alt=\"Swift Based Blog\" class=\"img-responsive banner center-block\" /></div> <div><img src=\"/img/random/random-5.jpg\" alt=\"Swift Based Blog\" class=\"img-responsive banner center-block\" /></div></div></div><div class=\"row\"><div class=\"col-xs-12\"><h1>".bytes
        
        finalContent += "Test Post 1".bytes
        finalContent += "</h1><img src=\"".bytes
        finalContent += "/img/random/random-\(imageNumber).jpg\" alt=\"Random Image \(imageNumber)\" class=\"alignleft feature-image img-responsive\" />".bytes
        finalContent += "<div class=\"content\">".bytes
        finalContent += post
        finalContent += "</div>".bytes
        finalContent += "</div></div</div></section>".bytes
        
        return finalContent
    }
    
}
