# -*- coding: utf-8 -*-

import tornado.ioloop
import tornado.web

import os
import web
import dbconn
dbconn.register_dsn("host=localhost dbname=postgres user=postgres password=1")

from handlers import *

settings = {
    "static_path":'statics',
    "template_path":'templates',
    "debug": True
}



handlers =[
    (r'/secretary/([a-z]+)?', stRestHandler),

    (r'/student', mainRestHandler),
    (r'/teacher', teaRestHandler),
    (r'/', IndexHandler),
    (r"/s/student/([0-9]+)?", secretaryRestHandler),#handlers.StudentRestHandler
    (r"/s/student/conflict",conflictHandler),
    (r'/(.*)', web.HtplHandler)
]

print(handlers)

application = tornado.web.Application(handlers, **settings)

if __name__ == "__main__":
    application.listen(8888)
    server = tornado.ioloop.IOLoop.instance()
    server.start()

