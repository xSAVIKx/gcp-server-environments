from os import path

from textgenrnn import textgenrnn

script_file_path = path.dirname(__file__) + path.sep
textgen = textgenrnn(name='ru_proverbs_chars',
                     config_path=script_file_path + 'ru_proverbs_chars_config.json',
                     weights_path=script_file_path + 'ru_proverbs_chars_weights.hdf5',
                     vocab_path=script_file_path + 'ru_proverbs_chars_vocab.json')


def generate_proverb(temperature=0.25, max_gen_length=256):
    """Generates a new proverb.

    :param temperature: the RNN temperature
    :param max_gen_length: max length of the proverb to be generated
    :return: a new proverb
    :rtype: list of str
    """
    response = textgen.generate(n=1,
                                temperature=[temperature],
                                max_gen_length=max_gen_length,
                                progress=False,
                                return_as_list=True)
    return response
