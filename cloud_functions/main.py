import logging

from ru_proverbs.generator import generate_proverb


def main(request):
    temperature = request.args.get('temperature', default=0.18)
    logging.info('Generating new proverbs with temperature: %s' % temperature)
    response = generate_proverb(float(temperature))
    logging.info('Proverb: %s' % response)
    return "Я Cloud Function и вот ваша поговорка: " + ''.join(response)


if __name__ == '__main__':
    print(generate_proverb())
