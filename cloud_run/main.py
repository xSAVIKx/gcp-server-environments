from flask import Flask

from ru_proverbs.generator import generate_proverb

app = Flask(__name__)


@app.route('/')
def root():
    response = generate_proverb()
    return ''.join(response)


if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8080, debug=True)
