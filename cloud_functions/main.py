from ru_proverbs.generator import generate_proverb


def main(request):
    """HTTP Cloud Function.
    Args:
        request (flask.Request): The request object.
        <http://flask.pocoo.org/docs/1.0/api/#flask.Request>
    Returns:
        The response text, or any set of values that can be turned into a
        Response object using `make_response`
        <http://flask.pocoo.org/docs/1.0/api/#flask.Flask.make_response>.
    """
    response = generate_proverb()
    return ''.join(response)


if __name__ == '__main__':
    print(generate_proverb())
