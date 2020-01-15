import tornado.ioloop
import tornado.web
class ABCHandler(tornado.web.RequestHandler):
    def get(self,x):
        m=int(x) if x is not None else 9
        html=''''''
        if m<10:
            for i in range(1, m+1):
                for j in range(1, i+1):
                    a='{}x{}={}\t'.format(j, i, i*j)
                    html+=a
                html+="<br>"
            self.write(html)
        else:
            self.write("请输入一个不超过9的正整数")
application = tornado.web.Application([
    (r"/([0-9]+)?", ABCHandler),
],debug=True)
if __name__ == "__main__":
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()