import logging

from flask import Flask, request
from ru_proverbs.generator import generate_proverb

app = Flask(__name__)


@app.route('/')
def root():
    temperature = request.args.get('temperature', default=0.18)
    logging.info('Generating new proverbs with temperature: %s' % temperature)
    response = generate_proverb(float(temperature))
    logging.info('Proverb: %s' % response)
    headers = {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Max-Age': '3600'
    }
    return ''.join(response), 200, headers


if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8080, debug=True)
