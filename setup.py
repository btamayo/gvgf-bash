from setuptools import setup


def readme():
    with open('README.rst') as f:
        return f.read()

setup(name='gvgf',
      version='0.1',
      description='gvgf',
      long_description=readme(),
      url='http://github.com/btamayo/gvgf',
      keywords='git gitversion semantic versioning semver automation',
      author='Bianca Tamayo',
      author_email='hi@biancatamayo.me',
      license='MIT',
      packages=['gvgf'],
      zip_safe=False,
      dependency_links=['https://github.com/petervanderdoes/gitflow-avh'],
      tests_require=['pytest', 'pytest-bdd'],
      setup_requires=['pytest-runner'])
