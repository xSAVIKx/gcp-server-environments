import logging

from ru_proverbs.generator import generate_proverb


def main(request):
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
    print(generate_proverb())
