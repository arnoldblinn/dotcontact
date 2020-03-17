import sys
import json
from bottle import request, response, HTTPResponse, route, run, ServerAdapter, template, static_file
from os.path import *

import dns.resolver
import base64

root = 'dotcontact.me'

def _get_txt(domain):
        
    try:
        dc = '_dotcontact.' + domain
        answers = dns.resolver.query(qname=dc, rdtype='TXT')
        if answers and len(answers) == 1:
            d = b''.join(answers[0].strings)
            d = base64.b64decode(d)
            j = json.loads(d)
            return j
    except:
        return None

    return None

def _get_json(host):

    headers = {'Content-Type': 'application/json',  'Access-Control-Allow-Origin' : '*'}
    if exists('static/' + host + '.json'):

        contents = open('static/' + host + '.json', 'r').read()

        return HTTPResponse(status=200, body=contents, headers=headers)
    else:
        contents = _get_txt(host)
        if contents:
            return HTTPResponse(status=200, body=json.dumps(contents), headers=headers)

    return HTTPResponse(status=404, body="{}", headers=headers)                          

@route('/', method=['GET', 'OPTIONS'])
def index():

    return template('query.tpl')

@route('/edit', method=['GET', 'OPTIONS'])
def edit():

    return template('edit.tpl')

@route('/dotcontact', method=['GET', 'OPTIONS'])
def dotcontact():

    domain = request.params['domain']

    return _get_json(domain)

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
