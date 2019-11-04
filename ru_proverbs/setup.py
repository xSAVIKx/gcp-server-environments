from setuptools import setup, find_packages

from ru_proverbs import __version__

with open("README.md", "r") as fh:
    long_description = fh.read()

CLASSIFIERS = [
    "Intended Audience :: Developers",
    "License :: OSI Approved :: MIT License",
    "Operating System :: OS Independent",
    "Programming Language :: Python",
    "Programming Language :: Python :: 3.5",
    "Programming Language :: Python :: 3.6",
    "Programming Language :: Python :: 3.7",
    "Programming Language :: Python :: 3.8"
]

setup(
    name='ru_proverbs',
    version=__version__,
    license='MIT',
    description='RU Proverbs generator',
    long_description=long_description,
    long_description_content_type='text/markdown',
    author='Yurii Serhiichuk',
    author_email='savik.ne[at]gmail.com',
    url='https://github.com/xSAVIKx/gcp-server-environments/tree/master/ru_proverbs',
    keywords=['python', 'textgenrnn', 'ML', 'AI'],
    packages=find_packages(),
    include_package_data=True,
    install_requires=[
        'tensorflow>=1.14.0',
        'textgenrnn>=1.5.0'
    ],
    classifiers=CLASSIFIERS,
    python_requires='>=3.5'
)
