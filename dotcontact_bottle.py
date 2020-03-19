import sys
import json
from bottle import request, response, HTTPResponse, route, run, ServerAdapter, template, static_file
from os.path import *

@route('/', method=['GET', 'OPTIONS'])
def index():

    return static_file('index.html', root='')

@route('/edit.html', method=['GET', 'OPTIONS'])
def edit():

    return static_file('edit.html', root='')

@route('/configure.html', method=['GET', 'OPTIONS'])
def configure():
    return static_file('configure.html', root='')

@route('/ping')
def ping():
    """
    Simple ping to see if the service is up and running
    """
    return HTTPResponse(status=200, body="")

@route('/static/<filename>')
def send_static(filename):
    return static_file(filename, root='static')

from gevent import monkey; monkey.patch_all()

if __name__ == '__main__':
    #run(host='0.0.0.0', port=sys.argv[1], debug=True)

    run(host='0.0.0.0', server='gevent', port=sys.argv[1], debug=True, certfile='server.crt', keyfile='server.key')
