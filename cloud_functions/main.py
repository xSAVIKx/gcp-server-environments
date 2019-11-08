from ru_proverbs.generator import generate_proverb


def main(request):
    response = generate_proverb()
    return "I'm Cloud Function and here is your proverb: " + ''.join(response)


if __name__ == '__main__':
    print(generate_proverb())
