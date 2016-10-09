struct CommonHandler {

    func getHeader() -> String {
        return "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"utf-8\"><title>PerfectPress</title><link rel=\"stylesheet\" href=\"/inc/bootstrap.min.css\"><link rel=\"stylesheet\" type=\"text/css\" href=\"/inc/slick.css\"/><link rel=\"stylesheet\" type=\"text/css\" href=\"/inc/slick-theme.css\"/><link rel=\"stylesheet\" href=\"/style.css\"></head><body><header><div class=\"container\"><div class=\"row\"><div class=\"col-sm-6\"><a href=\"/\"><img src=\"/img/logo@2x.png\" class=\"logo img-responsive\" id=\"header-logo\" /></a></div><div class=\"col-sm-6 text-right\"><nav><ul><li><a href=\"/\">Home</a></li><li><a href=\"/blog\">Blog</a></li></ul></nav></div></div></div></header>"
    }

    func getFooter() -> String {
        return "<footer><script src=\"/inc/bootstrap.min.js\"></script><script type=\"text/javascript\" src=\"/inc/jquery-1.11.0.min.js\"></script><script type=\"text/javascript\" src=\"/inc/jquery-migrate-1.2.1.min.js\"></script><script type=\"text/javascript\" src=\"/inc/slick.min.js\"></script><script src=\"/inc/dynamics.min.js\"></script><script src=\"/inc/animations.js\"></script></footer></body></html>"
    }

}
