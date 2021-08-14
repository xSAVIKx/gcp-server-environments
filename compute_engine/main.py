import logging
import sys

from pythonjsonlogger import jsonlogger


class StackdriverJsonFormatter(jsonlogger.JsonFormatter, object):
    def __init__(self, fmt="%(levelname) %(message)", style="%", *args, **kwargs):
        jsonlogger.JsonFormatter.__init__(self, fmt=fmt, *args, **kwargs)

    def process_log_record(self, log_record):
        log_record["severity"] = log_record["levelname"]
        del log_record["levelname"]
        return super(StackdriverJsonFormatter, self).process_log_record(log_record)


handler = logging.StreamHandler(sys.stdout)
formatter = StackdriverJsonFormatter()
handler.setFormatter(formatter)
root_logger = logging.getLogger()
root_logger.addHandler(handler)

from flask import Flask, request
from ru_proverbs.generator import generate_proverb

app = Flask(__name__)


@app.route("/")
def root():
    temperature = request.args.get("temperature", default=0.18)
    logging.info("Generating new proverbs with temperature: %s" % temperature)
    response = generate_proverb(float(temperature))
    logging.info("Proverb: %s" % response)
    headers = {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET",
        "Access-Control-Allow-Headers": "Content-Type",
        "Access-Control-Max-Age": "3600",
    }
    return "".join(response), 200, headers


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8080, debug=True)
