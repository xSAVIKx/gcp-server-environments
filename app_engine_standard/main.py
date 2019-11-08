import logging

from flask import Flask, request
from ru_proverbs.generator import generate_proverb

app = Flask(__name__)


@app.route('/')
def root():
    temperature = request.args.get('temperature', default=0.18)
    logging.info('Generating new proverbs with temperature: %s' % temperature)
    response = generate_proverb(temperature)
    logging.info('Proverb: %s' % response)
    return "Я App Engine Standard и вот ваша поговорка: " + ''.join(response)


if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8080, debug=True)
