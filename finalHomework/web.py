# -*- coding: utf-8 -*-

import json
import datetime
import tornado.web
import dbconn
import os


class BaseHandler(tornado.web.RequestHandler):
    print("staring BaseHandler")
    def db_cursor(self, autocommit=True):
        return dbconn.SimpleDataCursor(autocommit=autocommit)


class HtplHandler(BaseHandler):
    print("staring HtplHandler")
    def get(self, path):
        if not path: 
            path = 'index'
        page =path +".html"
        try:
            self.set_header("Content-Type", "text/html; charset=UTF-8")
            self.render(page)
        except IOError as e:
            if not os.path.exists(page): 
                raise tornado.web.HTTPError(404)
            raise

class RestHandler(BaseHandler):
    print("staring RestHandler")
    def read_json(self):
        json_obj = json.loads(self.request.body)
        return json_obj

    def write_json(self, data):
        json_str = json.dumps(data, cls=JsonDataEncoder)
        self.set_header('Content-type', 'application/json; charset=UTF-8')
        self.write(json_str)  



class JsonDataEncoder(json.JSONEncoder):
    print("staring JsonDataEncoder")
    def default(self, obj):
        if isinstance(obj, (datetime.date, datetime.datetime)):
            return obj.isoformat()
        elif isinstance(obj, (decimal.Decimal)) :
            return float(obj)
        else:
            return json.JSONEncoder.default(self, obj)
        


