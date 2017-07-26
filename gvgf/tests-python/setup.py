from setuptools import setup

setup(
   name='git_versioning',
   version='1.0',
   description='For Testing Git Flow Hooks',
   author='Bianca Tamayo',
   author_email='contact@biancatamayo.me',
   packages=['tests_tdd'],
   install_requires=['pytest', 'nose', 'pytest-bdd', 'contextlib2', 'pytest-catchlog'],
)
